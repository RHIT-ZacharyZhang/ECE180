close all;
clear all;
clc;
vr = VideoReader('clock.mp4');
a = vr.NumberofFrames;
vr1 = vision.VideoFileReader