function [t1,t2] = snippet(x,fs,fig)
%SNIPPET Play a short segment of an audio signal
%   T1 = SNIPPET(X,FS) interactively obtains start and stop times
%   of a segment of audio signal X with sampling rate FS Hz that has
%   already been plotted as either a time-domain plot or as a
%   spectrogram, plays the audio segment, and returns the segment's
%   start time T1 in seconds. SNIPPET requires the current figure
%   to contain either a 1-D plot of the audio signal X with a
%   properly-calibrated time axis or the spectrogram of X as created
%   by SPECTROGRAM.
%
%   T1 = SNIPPET(X,FS,FIGNUM) uses the designated figure number.
%
%   [T1,T2] = SNIPPET(...) returns the start and stop times
%   of the audio segment.
%
%   INSTRUCTIONS:
%   - The desired figure activates with a cross-hair cursor,
%   - Click between zero and three times:
%       - No click: Reuse the currently-selected time range
%       (initially the entire audio signal),
%       - One click: Define the start time and reuse the stop time,
%       - Two clicks: Define the start and stop times, or
%       - Three clicks: Exit and return these start and stop times.
%   - Press ENTER to display and hear the selected audio segment.
%
%   EXAMPLE: Work with the time-domain plot and then
%   two orientations of the the spectrogram
%     fs=1000;                      % sampling rate = 1kHz
%     t=0:1/fs:3-1/fs;              % sampled time array, 3 seconds
%     x=chirp(t,100,2,200,'q');     % quadratic-style chirp
%     plot(t,x)                     % 1-D time-domain plot
%     snippet(x,fs)                     % work from time-domain plot
%     spectrogram(x,128,120,128,1E3);   % spectrogram, vertical time
%     snippet(x,fs)                     % work from spectrogram
%     spectrogram(x,128,120,128,1E3,'yaxis');   % horizontal time
%     snippet(x,fs)                     % work from another spectrogram
%
%
%   ECE180: Introduction to Signal Processing
%   Rose-Hulman Institute of Technology

%   Created 11 Jul 2014

% Check for proper number of input arguments
narginchk(2,3)

% Use supplied figure number or
% default to current figure
if nargin == 3
    f = fig;
else
    f = gcf;
end

% Determine the type of plot
% 0 = time-domain plot
% 1 = spectrogram
ptype = ~isempty(get(gca(f),'ZTickLabel')); 

% If spectrogram, determine the time axis
% 0 = horizontal axis
% 1 = vertical axis
taxis = 0;
if ptype
    taxis = strcmp(get(get(gca(f),'YLabel'),'String'),'Time (s)');
end

% Find the time axis limit
tlim=length(x)/fs - 1/fs;

% Activate the figure
figure(f)

% Initialize the start and stop times
% to the entire signal
t1 = 0;
t2 = tlim;
d = t2 - t1;

% Display start-time text in upper left
% corner of plot
ytop = ylim;
ytop = ytop(2);
xtop = xlim;
xtop = xtop(1);
h=text(xtop,ytop,sprintf('%5.2f to %5.2f s',t1,t2), ...
    'FontName','Calibri',...
    'FontSize',14,...
    'FontWeight','bold',...
    'BackgroundColor','w',...
    'VerticalAlignment','bottom');

% Main loop
g=zeros(2);
while 1
    % Get the cursor position
    g=ginput;
 
    if size(g,1) >= 3
        % All done
        break
    elseif size(g,1) == 2
        % Define zone with two selected points
        if taxis
            % vertical
            t1 = g(1,2);
            t2 = g(2,2);
        else
            % horizontal
            t1 = g(1,1);
            t2 = g(2,1);
        end
        % Ensure that stop time is always
        % after start time
        s = sort([t1 t2]);
        t1 = s(1);
        t2 = s(2);
        d = t2 - t1;
    elseif size(g,1) == 1
        % reuse previous distance
        if taxis
            % vertical
            t1 = g(1,2);
        else
            % horizontal
            t1 = g(1,1);
        end
        t2 = t1 + d;
    end
  
    % Ensure that times are in bounds
    t1 = max(t1,0);
    t2 = min(t2,tlim);
        
    % Convert times to array indeces
    t1i=round(t1*fs)+1;
    t2i=round(t2*fs)+1;
    
    % Update display text
    set(h,'String',sprintf('%5.2f to %5.2f s',t1,t2))

    % Play the selected sound range
    sound(x(t1i:t2i),fs)
end

% Remove text label
delete(h)

% All done!
