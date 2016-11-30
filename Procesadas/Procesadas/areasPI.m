function aA =  areasPI()
%Calcula �reas de acuerdo a un an�lisis de im�gen

img = imread('SAMP770_0.99_Recortada.PNG');
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

