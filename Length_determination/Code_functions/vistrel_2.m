function [im_zeros_SA] = vistrel_2(Strel_AAA)

% Visualitza un Strel (ex: SA_AAA = strel('line', 10, 75) en una imatge de
% zeros, per a que es pugui veure bé.

SA_img = Strel_AAA.Neighborhood;
size_SA = size(SA_img);

im_zeros_SA = zeros(size_SA(1)+2, size_SA(2)+2);

im_zeros_SA(2:end-1,2:end-1) = SA_img;


end