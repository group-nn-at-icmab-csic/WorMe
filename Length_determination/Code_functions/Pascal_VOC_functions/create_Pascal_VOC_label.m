function create_Pascal_VOC_label(ruta_img, BB_props, cell_label_props, ruta_write_xml)

% Same as create_Pascal_VOC, but for each BoundingBox,
% the cell with the labels (create_Pascal_VOC) is determined.
%
% Note: in f'create_Pascal_VOC', the labels of the bounding boxes were "Celegans".
%
% Create a file with Pascal VOC notation from the description of
% the coordinates of the Bounding Boxes, coming from MATLAB.
%
%
% Variables
%       input
%       ruta_img - path of the image
%       BB_props - cell with the Bounding Boxes 
%           (normal MATLAB annotation (x, y, w, h), like imcrop or regionprop.)
%       ruta_write_xml - path of the Pascal VOC type output file
%       cell_label_props - cell with the annotations. 
%           example: {"Celegans", "NonCelegans", "Celegans", "Celegans"}
%
% See also
% MATLAB_BB_to_Pascal_VOC_prop
% comprove_Pascal_VOC


% START FUNCTION

% Read image
img_RGB = imread(ruta_img);
size_img_RGB = size(img_RGB);

% From MATLAB BB to Pascal VOC BB
cell_Pascal_VOC_props = {};
for n_obj = 1:numel(BB_props)
    PascalVOC_prop = floor(MATLAB_BB_to_Pascal_VOC_prop(BB_props{n_obj}));

    % To only one cell, with the structure:
    field_obj_bndbox = struct("xmin", PascalVOC_prop(1), "ymin", PascalVOC_prop(2), "xmax", PascalVOC_prop(3), "ymax", PascalVOC_prop(4));

    [cell_Pascal_VOC_props] = cell_insert_values(cell_Pascal_VOC_props, field_obj_bndbox);
end




% Number of objects
n_obj = numel(cell_Pascal_VOC_props);

field_obj_name = "Celegans";
field_obj_pose = "Unspecified";
field_obj_truncated = 0; 
field_obj_difficult = 0;

struct_all_obj = struct("name", cell_label_props, ...
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