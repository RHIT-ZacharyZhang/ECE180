function spectro(x,fs,tres)
%SPECTRO Play an audio signal and display its spectrogram
%   SPECTRO(X,FS) plays the audio signal X with
%   sampling rate FS in hertz, and displays the
%   spectrogram of the signal.
%
%   SPECTRO(X,FS,TRES) displays the spectrogram with a
%   time resolution of TRES milliseconds. TRES defaults
%   to 100 ms when the TRES argument is omitted.
%
%   EXAMPLE: Play a chirp and display its spectrogram 
%     fs=1000;                      % sampling rate = 1kHz
%     t=0:1/fs:3-1/fs;              % sampled time array, 3 seconds
%     x=chirp(t,100,2,200,'q');     % quadratic-style chirp
%     spectro(x,fs)                 
%
%
%   ECE180: Introduction to Signal Processing
%   Rose-Hulman Institute of Technology

%   Created 08 Jul 2014

% Set default value for time resolution, if necessary
if nargin < 3
    tres = 100;
end
framelength = floor((tres/1000)*fs);
numframes = floor(length(x)/framelength);

% Display the spectrogram:
% - set the FFT size to the same value as the frame length
% - use Hann window with 50% overlap
spectrogram(x,hann(framelength),0.5*framelength,framelength,fs,'yaxis');

% Play the sound with auto scaling
soundsc(x,fs)

% Show the colorbar
colorbar

% All done!
end

