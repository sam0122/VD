function aA =  areasPI()
%Calcula áreas de acuerdo a un análisis de imágen

img = imread('11X15_800_F0.8_35%D.PNG');
gray = rgb2gray(img);
%imshow(gray);
bw_img = im2bw(gray);
imshow(bw_img);
%{
[B,L] = bwboundaries(bw_img,'noholes');
stats = regionprops(L,'Area','perimeter');
area = [stats.Area];
%}
at = numel(gray);
aw = bwarea(bw_img);
aA = 1- aw / at;
end

