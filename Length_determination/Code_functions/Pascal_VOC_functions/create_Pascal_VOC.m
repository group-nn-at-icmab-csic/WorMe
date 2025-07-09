function create_Pascal_VOC(ruta_img, BB_props, ruta_write_xml)


% Crea un arxiu amb notació Pascal VOC a partir de la descripció de
% les coordenades dels Bounding Box, procedents de MATLAB.
%
%
% Variables
%   input
%       ruta_img - ruta de la imatge
%       BB_props - cell amb els Bounding Box (anotació normal de MATLAB (x, y, w, h), com imcrop o regionprop.)
%       ruta_write_xml - ruta del arxiu de sortida tipu Pascal VOC
%
%
% See also
% MATLAB_BB_to_Pascal_VOC_prop
% comprove_Pascal_VOC


% START FUNCTION

% Lectura imatge
img_RGB = imread(ruta_img);
size_img_RGB = size(img_RGB);

cell_Pascal_VOC_props = {};
for n_obj = 1:numel(BB_props)
    PascalVOC_prop = floor(MATLAB_BB_to_Pascal_VOC_prop(BB_props{n_obj}));

    % Passem a una sola cell, amb la forma d'estructura:
    field_obj_bndbox = struct("xmin", PascalVOC_prop(1), "ymin", PascalVOC_prop(2), "xmax", PascalVOC_prop(3), "ymax", PascalVOC_prop(4));

    [cell_Pascal_VOC_props] = cell_insert_values(cell_Pascal_VOC_props, field_obj_bndbox);
end

% Nº objectes
n_obj = numel(cell_Pascal_VOC_props);

field_obj_name = "Celegans";
field_obj_pose = "Unspecified";
field_obj_truncated = 0; 
field_obj_difficult = 0;


struct_all_obj = struct("name", cellstr(repelem(field_obj_name, n_obj)), ...
                    "pose", cellstr(repelem(field_obj_pose, n_obj)), ...
                    "truncated", num2cell(repelem(field_obj_truncated, n_obj)), ...
                    "difficult", num2cell(repelem(field_obj_difficult, n_obj)), ...
                    "bndbox", cell_Pascal_VOC_props);
                    %  'SecondField',num2cell(1:100))


[field_filename, field_folder, ~] = divide_file_folder(ruta_img);
field_path = ruta_img;


field_source = struct("database", "Unknown");

field_size = struct("width", size_img_RGB(2), "height", size_img_RGB(1), "depth", size_img_RGB(3));

field_segmented = 0;

field_object = struct_all_obj;

pascal_VOC_MATLAB = struct("folder", field_folder, ... % folder
                 "filename", field_filename, ... % filename
                 "path", field_path, ... % path
                 "source", field_source, ... % source (struct)
                 "size", field_size, ... % size (struct)
                 "segmented", field_segmented, ...
                 "object", field_object); % object (struct)


% writestruct(pascal_VOC_MATLAB, ruta_write_xml, 'FileType','xml', 'StructNodeName', "annotation")
writestruct(pascal_VOC_MATLAB, ruta_write_xml, 'FileType','xml', 'StructNodeName', "annotation")


% END FUNCTION

end