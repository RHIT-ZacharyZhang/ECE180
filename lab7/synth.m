function y=synth(f0,D,A,fs,voice)
% SYNTH Synthesize a single note to an audio waveform
%   Y = SYNTH(F0,D,A,FS,VOICE) synthesizes a single note to
%   an audio waveform based on the input arguments:
%
%   F0 = frequency in Hz,
%   D  = duration in seconds,
%   A  = amplitude between 0 and 1,
%   FS = sampling rate in Hz, and
%   VOICE = string constant to select the "voice" or type of sound. In this
%      template synthesizer, VOICE can be one of the following: 'sine' for
%      sine wave, 'sawtooth' for sawtooth wave, and 'null' for silence.
%
%   This function serves as an example template to create your own synthesizer.
%   Copy this file to an .m file with a different name, and then adjust the
%   function definition (first line) to match.
%
%   Find the "BEGIN VOICE DEFINITIONS" area of the code and extend or otherwise
%   modify the "case" lines of the "switch" statement to create a unique name 
%   for the voice and associated code to generate the waveform in the variable "y".
%
%   Example:
%      f0 = 440;      % 440Hz frequency, "Concert A" (A4)
%      D = 2;         % Two seconds duration
%      A = 0.9;       % 0.9 amplitude
%      fs = 20000;    % 20kHz sampling rate
%      v = 'sine';    % Sine wave voice
%      y = synth(f0,D,A,fs,v);  % Synthesize the waveform
%      sound(y,fs)    % Play the waveform
%
%   Adapted from "synth.m" originally created by Ken Schutte.
%   http://www.kenschutte.com/midi
%
%   See also:  READMIDI, MIDIINFO, MIDI2AUDIO

% Adapted for use in ECE180:
% 1. Converted main "if-else" statement to "switch" statement
% 2. Changed input arguments to more common names used in ECE180
%
%   ECE180: Introduction to Signal Processing
%   Rose-Hulman Institute of Technology
%   Last edited 18 Jul 2014

% ORIGINAL DOCUMENTATION:
% y=synth(freq,dur,amp,Fs,type)
%
% Synthesize a single note
%
% Inputs:
%  freq - frequency in Hz
%  dur - duration in seconds
%  amp - Amplitude in range [0,1]
%  Fs -  sampling frequency in Hz
%  type - string to select synthesis type
%         current options: 'fm', 'sine', or 'saw'

% Copyright (c) 2009 Ken Schutte
% more info at: http://www.kenschutte.com/midi



if nargin<5
  error('Five arguments required for synth()');
end

N = floor(D*fs);

if N == 0
  warning('Note with zero duration.');
  y = [];
  return;

elseif N < 0
  warning('Note with negative duration. Skipping.');
  y = [];
  return;
end

% MODIFIED: Replace next line
%n=0:N-1;
tt = (0:1/fs:D-1/fs)';

% MODIFIED: Convert "if-else" statement to "switch" statement
switch char(voice)

% ---BEGIN VOICE DEFINITIONS---------------------------------------------------

%    IMPORTANT: Do NOT modify any code outside of this region!

    case 'null'
        y = zeros(N,1);

    case 'sine'
        y = A*sin(2*pi*f0*tt);

    case 'sawtooth'
        y = A*2*(f0*tt-fix(f0*tt) - 0.5);	
        
% ---END VOICE DEFINITIONS-----------------------------------------------------

    otherwise
        error('Unknown voice type');
end

% smooth edges w/ 10ms ramp
if (D > .02)
  L = 2*fix(.01*fs)+1;  % L odd
  % MODIFIED: Remove transpose
  %ramp = bartlett(L)';  % odd length
  ramp = bartlett(L);  % odd length
  L = ceil(L/2);
  y(1:L) = y(1:L) .* ramp(1:L);
  y(end-L+1:end) = y(end-L+1:end) .* ramp(end-L+1:end);
end
