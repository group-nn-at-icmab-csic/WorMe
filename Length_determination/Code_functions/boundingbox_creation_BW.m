function [BW_zeros_krillin_bwconv] = boundingbox_creation_BW(BW_krillin)

% Given a singular binary image, its bounding box is returned in the form of a logical image.
%
% % Exemple variables
% BW_krillin = krillin_BW_2_largest_fin;
% imshow(BW_krillin)
% 
% % Exemple post execució
% imshow(BW_zeros_krillin_bwconv)
% size(BW_zeros_krillin_bwconv)
% size(BW_krillin)


% START OF THE FUNCTION

% Let's see if it's just one binary object or there's more than one:
numero_objectes = unique(bwlabel(BW_krillin));
if length(numero_objectes) ~= 2
    f = msgbox('More than one BW object.', 'Error','error');
end

% Obtain the Bounding box
BB_krillboca = regionprops(BW_krillin,'BoundingBox');  %<--- rellevant
BB_krillin = ceil(BB_krillboca.BoundingBox);

% Obtain the zeros image
zeros_krillin = zeros(size(BW_krillin));

% Bounding box graphics (standard)
% imshow(zeros_krillin)
% hold on
% rectangle('Position', BB_krillboca.BoundingBox+[-1 -1 +1 +1], 'EdgeColor','b', 'LineWidth', 1)
% hold off

%size(BW_krillin)
%size(zeros_krillin)

% GRAPH OF THE POINTS

% % Exemeple
% zeros_krillin2 = zeros_krillin;
% zeros_krillin2(BB_krillin(2), BB_krillin(1)) = 1;
% zeros_krillin2(BB_krillin(2), BB_krillin(1)+BB_krillin(3)) = 1;
% zeros_krillin2(BB_krillin(2)+BB_krillin(4), BB_krillin(1)) = 1;
% zeros_krillin2(BB_krillin(2)+BB_krillin(4), BB_krillin(1)+BB_krillin(3)) = 1;
% 
% imshow(zeros_krillin2)
% 
% % 49    77    48    24
% % x     y      x2    y2

% We make a zero with two dots, which will be used to make each line of the
% bounding box. line 1
zeros_krillin_l1 = zeros_krillin;
zeros_krillin_l1(BB_krillin(2), BB_krillin(1)) = 1;
zeros_krillin_l1(BB_krillin(2), BB_krillin(1)+BB_krillin(3)) = 1;

% l2
zeros_krillin_l2 = zeros_krillin;
zeros_krillin_l2(BB_krillin(2), BB_krillin(1)+BB_krillin(3)) = 1;
zeros_krillin_l2(BB_krillin(2)+BB_krillin(4), BB_krillin(1)+BB_krillin(3)) = 1;

% l3
zeros_krillin_l3 = zeros_krillin;
zeros_krillin_l3(BB_krillin(2)+BB_krillin(4), BB_krillin(1)) = 1;
zeros_krillin_l3(BB_krillin(2)+BB_krillin(4), BB_krillin(1)+BB_krillin(3)) = 1;

% l4
zeros_krillin_l4 = zeros_krillin;
zeros_krillin_l4(BB_krillin(2), BB_krillin(1)) = 1;
zeros_krillin_l4(BB_krillin(2)+BB_krillin(4), BB_krillin(1)) = 1;

% We do a cell of the images
cell_zeros_krillin_l = {zeros_krillin_l1, zeros_krillin_l2, ...
   zeros_krillin_l3, zeros_krillin_l4};

% We make a line for each image with two points, and join them to a main one.
% Image of zeros where the lines will go
zeros_krillin_bwconv = zeros_krillin;
for cada_bwconv = 1:4
    krillin_l = cell_zeros_krillin_l{cada_bwconv};
    % We do the line
    krillin_l_bwconv = bwconvhull(krillin_l);
    % Joined it
    zeros_krillin_bwconv = zeros_krillin_bwconv + krillin_l_bwconv; 
end
%imshow(zeros_krillin_bwconv)

% Igualem tots els valors a 1.
%tic
% zeros_krillin_bwconv_bw = imbinarize(zeros_krillin_bwconv);
zeros_krillin_bwconv(zeros_krillin_bwconv==2) = 1;
%toc

%unique(zeros_krillin_bwconv_bw)

BW_zeros_krillin_bwconv = logical(zeros_krillin_bwconv);
%class(BW_zeros_krillin_bwconv)
%imshow(BW_zeros_krillin_bwconv)


% FINAL OF THE FUNCTION


end