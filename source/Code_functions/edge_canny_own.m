function [BW_edges_final_p] = edge_canny_own(imageArray_cropped)

% Given an RGB image, where there is only one binary object (which can be obtained
% from a pre-processing of the binary objects, to identify
% these), the image is obtained by canny filter.



BW_edge_approxcanny_cropped = edge(imadjust(im2gray(imageArray_cropped)), "approxcanny");
%imshow(BW_edge_approxcanny_cropped)

for cada_valor = (0.5:2:100)
    BW_proba = bwareaopen_percentage(BW_edge_approxcanny_cropped, cada_valor);
    if unique(BW_proba) == 0
        cada_valor_final = cada_valor_anterior;
        break
    end
    cada_valor_anterior = cada_valor;
end
BW_edge_approxcanny_cropped_f = bwareaopen_percentage(BW_edge_approxcanny_cropped, cada_valor_final);
%imshow(BW_edge_approxcanny_cropped_f)

BW_edge_canny_cropped = edge(imadjust(im2gray(imageArray_cropped)), "Canny");
%imshow(BW_edge_canny_cropped)


% Operation between edge masks
% Now we will operate and subtract the masks.
%imshow(BW_edge_approxcanny_cropped_f)
%imshow(BW_edge_canny_cropped)

% Processing of the approxcanny
BW_BW_edge_approxcanny_cropped_f_proc = imclose(BW_edge_approxcanny_cropped_f, strel("disk", 1));
%imshow(BW_BW_edge_approxcanny_cropped_f_proc)
BW_BW_edge_approxcanny_cropped_f_proc = imfill(BW_BW_edge_approxcanny_cropped_f_proc, "holes");
%imshow(BW_BW_edge_approxcanny_cropped_f_proc)

% Rest masks
BW_edges_final_t = (BW_BW_edge_approxcanny_cropped_f_proc - BW_edge_canny_cropped) >0;
%imshow(BW_edges_final_t)

% Process
BW_edges_final_p = imfill(BW_edges_final_t, "holes");
%imshow(BW_edges_final_p)


% We obtain the bigger object
BW_edges_final_p = bwpropfilt(BW_edges_final_p, "Area", 1, "largest");
%imshow(BW_edges_final_p)
%imshowpair(imageArray_cropped, BW_edges_final_p, "montage")

% We separate by components that are not connected to each other:

% If we only take the largest element of this image:
% (with the function bwconncomp(BW_edges_final_p, 4) )
[BW_edges_final_p] = obtain_major_connected(BW_edges_final_p, 4);
%imshow(BW_edges_final_p)
%imshowpair(imageArray_cropped, BW_edges_final_p, "montage")

% We do dilate, to compensate the other:
BW_edges_final_p = imdilate(BW_edges_final_p, strel("disk", 1));

end