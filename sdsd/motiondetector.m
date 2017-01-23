%% clear up the wordspace before 
close all hidden;
clear;

%% initialize the video reader and player.
vr = webcam('Integrated Camera'); % set up the camera
vp=vision.DeployableVideoPlayer; % set up the video player
preview(vr);

%% set up the filtering thresholds 
threshold = 20;
contithred = 150 ;
se = strel('disk',35);

% set the first reference frame
or = snapshot(vr);
f = 1;
while ~isempty(findall(0,'type','figure'))
   re = rgb2gray(or); % use the last frame as the reference
   or = snapshot(vr); % get the photo taken by the camera
   % process each frame of the picture and generate motion map c.
   gr = rgb2gray(or);
   a = ( gr - re > threshold ) | ( re - gr > threshold );
   b = bwareaopen(a , contithred);
   c = imclose( b ,se );

   % copy the original frame
   d = or;
   cc = bwconncomp(c) ;
   n = cc.NumObjects;
   % loops through each moving objects detected and put boxes around them
   if(n > 0 )
        for j = 1:n
            r = regionprops(cc);
            d = insertShape(d,'Rectangle',r(j).BoundingBox);
        end
   end
   % play the videa, so we can see the processed video.
   step(vp,d);
   if f <= 250
        saved(:,:,:,f) = d;
        f = f+1;
   end
   closePreview(vr);% get rid of the preview window
end
% release the camera, so we can use it again.
clear vr;

% save the 250 frame output
vw=VideoWriter('motionDetecter.mp4','MPEG-4');
vw.Quality = 100;
open(vw);
writeVideo(vw,saved);
close(vw);

