function [BW_zeros_krillin_bwconv] = boundingbox_creation_BW(BW_krillin)

% Donada una imatge binària singular, es retorna el bounding box d'aquesta en forma d'imatge llogica.
%
% % Exemple variables
% BW_krillin = krillin_BW_2_largest_fin;
% imshow(BW_krillin)
% 
% % Exemple post execució
% imshow(BW_zeros_krillin_bwconv)
% size(BW_zeros_krillin_bwconv)
% size(BW_krillin)


% INICI DE LA FUNCIÓ

% Mirem si és sols un objecte binari o n'hi ha més d'un:
numero_objectes = unique(bwlabel(BW_krillin));
if length(numero_objectes) ~= 2
    f = msgbox('More than one BW object.', 'Error','error');
end

% Obtain the Bounding box
BB_krillboca = regionprops(BW_krillin,'BoundingBox');  %<--- rellevant
BB_krillin = ceil(BB_krillboca.BoundingBox);

% Obtenim imatge de zeros
zeros_krillin = zeros(size(BW_krillin));

% Graficació del Bunding box (estándard)
% imshow(zeros_krillin)
% hold on
% rectangle('Position', BB_krillboca.BoundingBox+[-1 -1 +1 +1], 'EdgeColor','b', 'LineWidth', 1)
% hold off

%size(BW_krillin)
%size(zeros_krillin)

% GRAFIQUEM ELS PUNTS

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

% Fem un zeros amb dos punts, el qual es farà servir per a fer cada linia del bounding box.
%linia 1
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

% Fem cell de les imatges
cell_zeros_krillin_l = {zeros_krillin_l1, zeros_krillin_l2, ...
   zeros_krillin_l3, zeros_krillin_l4};

% Fem línia per a cada imatge amb dos punts, i les juntem a una principal.
% Imatge de zeros on aniràn les linies
zeros_krillin_bwconv = zeros_krillin;
for cada_bwconv = 1:4
    krillin_l = cell_zeros_krillin_l{cada_bwconv};
    % Fem la línia
    krillin_l_bwconv = bwconvhull(krillin_l);
    % La juntem
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


% FI DE LA FUNCIO


end