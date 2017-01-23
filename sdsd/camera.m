
close all hidden;
clear;
%% initialize h
h = -ones(3);
h(2,2) = 8;
h = h -0.4;
h = 10*h;
%% initialize the video reader and player.
vr = webcam('Integrated Camera');
vw=VideoWriter('soccer-stream.mp4','MPEG-4');
open(vw);
vp=vision.DeployableVideoPlayer;
preview(vr);
% play the fun video
a = snapshot(vr);
se = strel('disk',25);
threshold = 6;
contithred = 100;
f = 1;
while ~isempty(findall(0,'type','figure'))
   p = a;
   a = snapshot(vr); 
   % get the image
%     a(:,:,1) = imfilter(a(:,:,1), hr);
%     a(:,:,2) = imfilter(a(:,:,2), hg);
%     a(:,:,3) = imfilter(a(:,:,3), hb);
   d = max((a-p)/2,(p-a)/2);
   d = rgb2gray(d);
   m = d > threshold;
   m = bwareaopen( m , contithred);
   o = imclose( m ,se );
   for i = 1 : 6
       o = imclose( o ,se );
   end
   moving = a*0;
   for i = 1: 480
       for j = 1:640
           if o(i,j)
               moving(i,j,:)=a(i,j,:);
           end
       end
   end
%    d = imfilter(d , h); % process it will our filter h
   step(vp,moving); % stream it in the deployable video player
   closePreview(vr); % close the disturbing preview window.
%    if max(max(max(moving)))>50
%         saved(:,:,:,f) = moving;
%         f = f+1;
%    end
end
clear vr;
release(vp);

% vw=VideoWriter('afternoon.mp4','MPEG-4');
% vw.Quality = 100;
% vw.FrameRate = 7;
% open(vw);
% writeVideo(vw,saved);
% close(vw);