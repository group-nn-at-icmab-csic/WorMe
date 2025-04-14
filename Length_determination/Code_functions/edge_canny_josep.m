function [BW_edges_final_p] = edge_canny_josep(imageArray_cropped)

% Donada una imatge en rgb, on sols hi ha un objecte binari (es pot obtenir
% a partir d'un pre- processament dels objectes binaris, per a identificar
% aquests), s'obté la imatge per filtre de canny.
%
%
% Nota: per entendre millor la funció, veure 2022_07_27_edge_a_regions


BW_edge_approxcanny_cropped = edge(imadjust(im2gray(imageArray_cropped)), "approxcanny");
%imshow(BW_edge_approxcanny_cropped)

for cada_valor = (0.5:2:100)
    BW_proba = bwareaopen_percentatge(BW_edge_approxcanny_cropped, cada_valor);
    if unique(BW_proba) == 0
        cada_valor_final = cada_valor_anterior;
        break
    end
    cada_valor_anterior = cada_valor;
end
BW_edge_approxcanny_cropped_f = bwareaopen_percentatge(BW_edge_approxcanny_cropped, cada_valor_final);
%imshow(BW_edge_approxcanny_cropped_f)

BW_edge_canny_cropped = edge(imadjust(im2gray(imageArray_cropped)), "Canny");
%imshow(BW_edge_canny_cropped)


% Opearció entre màscares d'edge
% Ara operarem i restarem les mascares.
%imshow(BW_edge_approxcanny_cropped_f)
%imshow(BW_edge_canny_cropped)

% Processament de la approxcanny
BW_BW_edge_approxcanny_cropped_f_proc = imclose(BW_edge_approxcanny_cropped_f, strel("disk", 1));
%imshow(BW_BW_edge_approxcanny_cropped_f_proc)
BW_BW_edge_approxcanny_cropped_f_proc = imfill(BW_BW_edge_approxcanny_cropped_f_proc, "holes");
%imshow(BW_BW_edge_approxcanny_cropped_f_proc)

% Restem màscares
BW_edges_final_t = (BW_BW_edge_approxcanny_cropped_f_proc - BW_edge_canny_cropped) >0;
%imshow(BW_edges_final_t)

% Processem
BW_edges_final_p = imfill(BW_edges_final_t, "holes");
%imshow(BW_edges_final_p)


% Obtenim l'objecte més gran
BW_edges_final_p = bwpropfilt(BW_edges_final_p, "Area", 1, "largest");
%imshow(BW_edges_final_p)
%imshowpair(imageArray_cropped, BW_edges_final_p, "montage")

% Separem per components que no siguin cpnnectats entre sí:


% Si sols agafem l'element més gran d'aquesta imatge:
% (amb la funció bwconncomp(BW_edges_final_p, 4) )
[BW_edges_final_p] = obtenir_major_conected(BW_edges_final_p, 4);
%imshow(BW_edges_final_p)
%imshowpair(imageArray_cropped, BW_edges_final_p, "montage")

% Fem un dilate, per a compensar la resta:
BW_edges_final_p = imdilate(BW_edges_final_p, strel("disk", 1));

end