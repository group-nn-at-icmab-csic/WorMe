function [BB_values_list, proporcio_img_list] = retallar_BB_BWimg(BW_final)

% Given a binary image with multiple objects, the bounding box values and proportions of
% them are returned.
%
% Donada una imatge amb varis objectes binaris, es retorna els bounding box
% d'aquesta.

% INICI FUNCIÓ

% Variables de sortida
BB_values_list = [];
proporcio_img_list = [];

% __Agafem cada objecte binaria de la imatge__
[BW_label, num] = bwlabel(BW_final);

% Per cada objecte de la imatge binaria:
for n_val = 1:num

            % Agafem un objecte
            BW_object = BW_label == n_val;

            [~, BB_values, proporcio_img_new] = retallar_BWimatge_BB_2(BW_object, 5);

            BB_values_list = [BB_values_list; BB_values];

            proporcio_img_list = [proporcio_img_list; proporcio_img_new];

end

% FINAL FUNCIÓ

end