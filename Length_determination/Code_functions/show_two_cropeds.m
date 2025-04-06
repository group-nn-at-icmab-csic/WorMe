function show_two_cropeds(img1, img2, xy_croped)

% Donades dos imatges amb la mateixa dimensió, i els punts on es tallen
% d'aquestes, la funció mostra la regió d'ambdós imatges.
%

% [BW_new_crop, xy_croped] = imcrop(BW_new); close
img1_crop = retallar_imatges_punts(img1, xy_croped);
img2_crop = retallar_imatges_punts(img2, xy_croped);
imshow_pair = imshowpair(img1_crop, img2_crop, "montage"); imshow(imshow_pair.CData, 'InitialMagnification','fit')

end