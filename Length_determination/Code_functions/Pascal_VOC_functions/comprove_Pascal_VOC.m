function [img_RGB_sortida] = comprove_Pascal_VOC(xml_file_2, img_ex)


% Donat un arxiu Pascal VOC xml i una imatge associada, retorna el
% BoudingBox de la imatge per a comprovar que les coordeandes són coherents
% amb les anotacións.
%
%
%
%
% % Exemple
% xml_file_2 = "2023_01_03_Generar_PascalVOC\Anotacio exemple 2\0_pvoc_imglab_Pascal_VOC.xml";
% img_ex = imread("2023_01_03_Generar_PascalVOC\Anotacio exemple 2\Image_961.jpg");
%
% [img_RGB_sortida] = comprove_Pascal_VOC(xml_file_2, img_ex)
%
% See also
% create_Pascal_VOC
% MATLAB_BB_to_Pascal_VOC_prop


% START FUNCTION

if isfile(xml_file_2)

    xml_struct = readstruct(xml_file_2);
    

    n_obj = length(xml_struct.object); % Numero d'objectes.

    img_RGB_sortida = img_ex;

    for n_object = 1:n_obj
    
        BB_prop = pascal_VOC_to_MATLAB_BB_prop(xml_struct.object(n_object).bndbox); % BB en notació MATLAB
    
        [img_RGB_sortida] = pintar_BB_img_eix(img_RGB_sortida, BB_prop, true, 1);
    end
        
    % imshow(img_RGB_sortida)


end

% END FUNCTION

end