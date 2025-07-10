function [MATLAB_prop] = pascal_VOC_to_MATLAB_BB_prop(pascal_VOC_prop)

% Goes from the Pascal VOC structure to the MATLAB type structure.

    xmin_M = pascal_VOC_prop.xmin;
    ymin_M = pascal_VOC_prop.ymin;
    width = pascal_VOC_prop.xmax - pascal_VOC_prop.xmin;
    height = pascal_VOC_prop.ymax - pascal_VOC_prop.ymin;

    MATLAB_prop = [xmin_M ymin_M width height];

end