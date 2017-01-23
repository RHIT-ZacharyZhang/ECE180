function cmap = spectral
%SPECTRAL Spectral colormap with black/white extremes
%   SPECTRAL returns a 256x3 colomap that features
%   twenty distinct color bands arranged in spectral
%   order with white and black at the extremes.

%   ECE180: Introduction to Signal Processing
%   Rose-Hulman Institute of Technology
%   Created 10 Jul 2014

% Open the colormap text file
[nfile, message]=fopen('pcolor.lut','r');
if nfile==-1
        fprintf('\n*** Error: %s\n\n',message);
        return;
end

% Read the data into a matrix
cmap=fscanf(nfile,'%f',[4 inf])';

% Close the file
fclose(nfile);

% Remove the first column
cmap(:,1)=[];

% Scale to range 0 to 1
cmap = cmap/255;

% All done
end

