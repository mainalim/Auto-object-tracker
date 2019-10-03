function [img, bw,xm,ym] = selfmadetracking(img, thresh)


%% Extract RGB color components
r = img(:,:,1);
g = img(:,:,2);
b = img(:,:,3);


%% Calculate green
justGreen = g - r/2 - b/2;

%% Threshold the image
bw = justGreen > thresh;
bw = bwareaopen(bw, 50);
%% Find center
[x, y] = find(bw);
if ~isempty(x) && ~isempty(y)
    xm = round(mean(x));
    ym = round(mean(y));
    
    %% Create a red dot
    xx = max(1, xm-5):min(xm+5, size(bw, 1));
    yy = max(1, ym-5):min(ym+5, size(bw, 2));
    bwbw = zeros(size(bw), 'uint8');
    bwbw(xx, yy) = 255;
    
    %% Create output image
    img(:,:,1) = uint8(r + bwbw);
    img(:,:,2) = uint8(g - bwbw);
    img(:,:,3) = uint8(b - bwbw);
else
    xm=0;ym=0;area=0;
end

