function [y,fs]=midi2audio(notes,fs,synthname,voicemap)
% MIDI2AUDIO Render MIDI notes to audio
%   [Y,FS] = MIDI2AUDIO(NOTES) renders the NOTES matrix returned from 
%   MIDIINFO.M to the stereo audio waveform Y using the default sampling rate 
%   FS = 44.1kHz, the default software synthesizer SYNTH.M, and the default 
%   voice map (sine wave for all active channels except Channel 10 (percussion)
%   which is not rendered).
%
%   [Y,FS] = MIDI2AUDIO(NOTES,FS) uses the specified sampling rate FS
%   in Hz.
%
%   [Y,FS] = MIDI2AUDIO(NOTES,FS,SYNTHNAME,VOICEMAP) uses the named
%   software synthesizer SYNTHNAME (a string constant or function handle that
%   refers to a function modelled on SYNTH.M) with voice mapping VOICEMAP.
%   VOICEMAP is a cell array of string constants that map MIDI channel
%   numbers to voices defined in SYNTHNAME. VOICEMAP cells can also contain a
%   3x1 cell array to specify the voice, pan position angle (-90deg hard left, 
%   0deg center, +90deg hard right), and level in dB.
%
%   Example:
%      m = readmidi('canon.mid');   % Load Pachelbel's "Canon in D"
%      n = midiInfo(m,0);           % Retrieve channels, notes, and timing
%      unique(n(:,2))+1             % Show active channels
%                                   % Create voice map:
%      vm{1} = {'sawtooth',0,-15};   % Violin 1: sawtooth voice, panned center, -15dB
%      vm{2} = {'sawtooth',-70,-15}; % Violin 2: panned left
%      vm{3} = {'sawtooth',70,-15};  % Violin 3: panned right
%      vm{4}='sine';                % Continuo: defaults to center pan and 0dB
%      vm{5}={'sawtooth',0,-6};     % Pizzicato: center pan, -6dB
%      fs = 44100;                  % CD-quality sampling rate (44.1 kHz)
%      y = midi2audio(n,fs,@synth,vm); % render to audio with default
%                                   % Synthesizer and user-defined voice map
%      p = audioplayer(y,fs);       % Create an audio player object
%      play(p)                      % Play the audio; use pause(p), resume(p),
%                                   % and stop(p) as needed
%
%   Adapted from "midi2audio.m" originally created by Ken Schutte.
%   http://www.kenschutte.com/midi
%
%   See also: READMIDI, MIDIINFO, SYNTH, AUDIOPLAYER, PLAY

% Adapted for use in ECE180 to allow multitimbral synthesis:
% 1. The input argument "voicemap" is now a cell array of 
%    strings instead of a single string. "voicemap" can also
%    contain a 3-element cell array to specify voice name,
%    pan position (-90 to +90), and level in dB. A 2-element
%    cell array that omits level is also acceptable.
% 2. The new argument "synthname" contains a function name or
%    function handle so that the "synth" function does not 
%    have to be hardcoded into this function.
%
%   ECE180: Introduction to Signal Processing
%   Rose-Hulman Institute of Technology
%   First revision: 18 Jul 2014
%   20 Oct 2014: Normalize with max(abs(y(:)))

% ORIGINAL DOCUMENTATION:
% y = midi2audio(input, Fs, synthtype)
% y = midi2audio(input, Fs)
% y = midi2audio(input)
%
% Convert midi structure to a digital waveform
%
% Inputs:
%  input - can be one of:
%    a structure: matlab midi structure (created by readmidi.m)
%    a string: a midi filename
%    other: a 'Notes' matrix (as ouput by midiInfo.m)
%
%  synthtype - string to choose synthesis method
%      passed to synth function in synth.m
%      current choices are: 'fm', 'sine' or 'saw'
%      default='fm'
%
%  Fs - sampling frequency in Hz (beware of aliasing!)
%       default =  44.1e3

% Copyright (c) 2009 Ken Schutte
% more info at: http://www.kenschutte.com/midi



% MODIFIED: Handle defaults
narginchk(1,4);
if (nargin == 1)
    % Notes available,
    % use default sampling rate
    fs=44.1e3;
end
if (nargin <= 3)
    % Notes and sampling rate available;
    % use default synthesizer, even if specified
    % because the voice map is not available
    warning('Cannot use ''%s'' without a voice map',synthname);
    synthname='synth';
    voicemap=repmat({'sine',0,0},16,1);
    voicemap{10}={'null',0,0};
end

% NEW: Extend partial-length voice maps
for k=length(voicemap)+1:16
    voicemap{k}={'null',0,0};
end

% NEW: Enter default values for missing voicemap entries
for k=1:length(voicemap)
    if isempty(voicemap{k})
        % Null entry, use default
        voicemap{k} = {'null',0,0};
    elseif ~iscell(voicemap{k})
        % Single string, convert to cell array
        voicemap{k} = {voicemap{k},0,0};
    elseif length(voicemap{k}) == 1
        % Cell array with single element
        voicemap{k}{2} = 0;
        voicemap{k}{3} = 0;
    elseif length(voicemap{k}) == 2
        % Cell array with two elements
        voicemap{k}{3} = 0;
    end
end

% NEW: Convert all levels in dB to linear gain and
% calculate left/right scale factors from pan
gL = ones(16,1);
gR = gL;
for k=1:length(voicemap)
    voicemap{k}{3} = 10^(voicemap{k}{3}/20);
    gL(k)=cosd(voicemap{k}{2}/2 + 45);
    gR(k)=sind(voicemap{k}{2}/2 + 45);
end

endtime = -1;
if (isstruct(notes))
  [Notes,endtime] = midiInfo(notes,0);
elseif (ischar(notes))
  [Notes,endtime] = midiInfo(readmidi(notes), 0);
else
  Notes = notes;
end

% t2 = 6th col
if (endtime == -1)
  endtime = max(Notes(:,6));
end
if (length(endtime)>1)
  endtime = max(endtime);
end

% MODIFIED: change to column vector, and
% support stereo
% = zeros(1,ceil(endtime*fs));
yL = zeros(ceil(endtime*fs),1);
yR = yL;

% Main loop
for i=1:size(Notes,1)

  % NEW: Channel
  ch = Notes(i,2)+1;
  
  f = midi2freq(Notes(i,3));
  dur = Notes(i,6) - Notes(i,5);
  % MODIFIED: Add level as scale factor
  %amp = Notes(i,4)/127;
  amp = Notes(i,4)/127 * voicemap{ch}{3};
 
  % MODIFIED: Replace next line
  %yt = synth(f, dur, amp, fs, synthtype);
  yt = feval(synthname,f, dur, amp, fs, voicemap{ch}{1});

  n1 = floor(Notes(i,5)*fs)+1;
  N = length(yt);  

  % MODIFIED: Remove "reshape" function and make stereo tracks
  % ensure yt is [1,N]:
  %y(n1:n1+N-1) = y(n1:n1+N-1) + reshape(yt,1,[]);
  yL(n1:n1+N-1) = yL(n1:n1+N-1) + gL(ch)*yt;
  yR(n1:n1+N-1) = yR(n1:n1+N-1) + gR(ch)*yt;

end

%NEW: Add normalization to +/- 1 range
y = [yL yR];
y = y / max(abs(y(:)));
