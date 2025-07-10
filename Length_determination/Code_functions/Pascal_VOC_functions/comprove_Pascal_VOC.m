function [img_RGB_sortida] = comprove_Pascal_VOC(xml_file_2, img_ex)


% Given a Pascal VOC xml file and an associated image, return the
% BoundingBox of the image to check that the coordinates are coherent
% with the annotations.
%
%
% [img_RGB_sortida] = comprove_Pascal_VOC(xml_file_2, img_ex)
%
% See also
% create_Pascal_VOC
% MATLAB_BB_to_Pascal_VOC_prop


% START FUNCTION

if isfile(xml_file_2)

    xml_struct = readstruct(xml_file_2);
    

    n_obj = length(xml_struct.object); % Number of objects

    img_RGB_sortida = img_ex;

    for n_object = 1:n_obj
    
        BB_prop = pascal_VOC_to_MATLAB_BB_prop(xml_struct.object(n_object).bndbox); 
        % BB in MATLAB notation
    
        [img_RGB_sortida] = paint_BB_img_axis(img_RGB_sortida, BB_prop, true, 1);
    end
        
    % imshow(img_RGB_sortida)


end

% END FUNCTION

end