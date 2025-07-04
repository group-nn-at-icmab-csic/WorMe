function [PascalVOC_prop] = MATLAB_BB_to_Pascal_VOC_prop(MATLAB_prop)

% Donades les coordenades d'un Bounding Box procedent de la notació de
% MATLAB, es retorna la notació tipu Pascal VOC, on:
%
% MATLAB : [xmin, ymin, width, height]
% 
% Pascal VOC: [xmin, ymin, xmax, ymax]
%       
% See also
% create_Pascal_VOC
% comprove_Pascal_VOC


% INICI FUNCIÓ

    xmin_PascVOC = MATLAB_prop(1); % xmin 
    ymin_PascVOC = MATLAB_prop(2); % ymin
    xmax_PascVOC = MATLAB_prop(1) + MATLAB_prop(3); % xmin + w
    ymax_PascVOC = MATLAB_prop(2) + MATLAB_prop(4); % xmin + w
    
    PascalVOC_prop = [xmin_PascVOC ymin_PascVOC xmax_PascVOC ymax_PascVOC];


% FINAL FUNCIÓ

end