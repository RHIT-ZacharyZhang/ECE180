function playspec(x,fs,tres)
%PLAYSPEC Play an audio signal and display its spectrogram
%   PLAYSPEC(X,FS) plays the audio signal X with
%   sampling rate FS in hertz, and displays the
%   spectrogram of the signal.
%
%   PLAYSPEC(X,FS,TRES) displays the spectrogram with a
%   time resolution of TRES milliseconds. TRES defaults
%   to 100 ms when the TRES argument is omitted.
%

%   ECE180: Introduction to Signal Processing
%   Rose-Hulman Institute of Technology
%   Created 08 Jul 2014

% Set default value for time resolution, if necessary
if nargin < 3
    tres = 100;
end
framesize = floor((tres/1000)*fs);
numframes = floor(length(x)/framesize);

% NOTE: need to better understand
% these parameters...

% produce recognizable frames
spectrogram(x,hann(framesize),0.5*framesize,framesize,fs);

% produce recognizable frames
%spectrogram(x,framesize,0,2*framesize,fs);

% produce much less leakage (?)
%spectrogram(x,framesize/4,0,2*framesize,fs);

soundsc(x,fs)
colorbar
end

