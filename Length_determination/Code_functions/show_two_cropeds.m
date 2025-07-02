function show_two_cropeds(img1, img2, xy_croped)

% Given two images with the same size and the points where they are cut,
% the function shows the region of both images.
%

% [BW_new_crop, xy_croped] = imcrop(BW_new); close
img1_crop = retallar_imatges_punts(img1, xy_croped);
img2_crop = retallar_imatges_punts(img2, xy_croped);
imshow_pair = imshowpair(img1_crop, img2_crop, "montage"); imshow(imshow_pair.CData, 'InitialMagnification','fit')

end