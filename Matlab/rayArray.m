function [rays] = rayArray(imgPixs,imgPixSize, detPixs,...
    detPixSize, detToObjDist, detSubSample)
% Generates unit vectors from 2D image plane to detector pixels. Can turn
% on subsampling in both planes. Right handed coordinate system with z = 0
% at the image plane. Indexing always goes from left to right, starting at
% the top and going down when viewed from behind  the object towards the 
% detector i.e.  <) -> |object| -> |collimator| -> |detector| ; |1 2 3 4
% ... 5 6 7 etc|
%   imgPixs = [pixX,pixY] number of pixels in x and y
%   imgPixSize = physical size of the pixel (assumed square)
%   detPixs = [detX,detY]
%   detPixSize = physical size of detector pixel
%   detToObjDist = distance between midpoints of the image and det plane
%   detSubSample = subsampling det pixels, downsampled to detSize
% OUTPUT
% rays = normalized rays from image to detector plane. Format is 3D matrix

detX = detPixs(1);
detY = detPixs(2);

detSubX = detSubSample(1);
detSubY = detSubSample(2);

imgPixX = imgPixs(1);
imgPixY = imgPixs(2);

eleDX = detX*detSubX;
eleDY = detY*detSubY;
rayRaw = cell(eleDX,eleDY,imgPixX*imgPixY);

% Detector Grid Values
if rem(eleDX,2) == 0 
    xDR = (0.5) * (eleDX - 1); % (x)-(d)et (r)ange
else
    xDR = (0.5) * eleDX;
end

if rem(eleDY,2) == 0
    yDR = (0.5) * (eleDY-1); 
else
    yDR = (0.5) * eleDY;
end

% Object grid values
if rem(imgPixX) == 0 
    xOR = (0.5) * (imgPixX - 1); % (x)-(d)et (r)ange
else
    xOR = (0.5) * imgPixX;
end

if rem(imgPixY,2) == 0
    yOR = (0.5) * (imgPixY-1); 
else
    yOR = (0.5) * imgPixY;
end

% Meshing
if size(detPixSize) == 2 %detPixSize = (detPixSizeX, detPixSizeY)
    detMeshX = (-xDR:1:xDR) * detPixSize(1);
    detMeshY = (-yDR:1:yDR) * detPixSize(2);
else
    if size(detPixSize) == 1
        detMeshX = (-xDR:1:xDR) * detPixSize;
        detMeshY = (-yDR:1:yDR) * detPixSize;
    else
        % THIS SHOULD BE AN ERROR CALL
    end
end

if size(imgPixSize) == 2 %imgPixSize = (imgPixSizeX, imgPixSizeY)
    imgMeshX = (-xOR:1:xOR) * imgPixSize(1);
    imgMeshY = (-yOR:1:yOR) * imgPixSize(2);
else
    if size(imgPixSize) == 1
        imgMeshX = (-xOR:1:xOR) * imgPixSize;
        imgMeshY = (-yOR:1:yOR) * imgPixSize;
    else
        % THIS SHOULD BE AN ERROR CALL
    end
end


%% WHERE YOU LEFT OFF, NOW CREATE THE MESHGRID AND VECTORS
end

