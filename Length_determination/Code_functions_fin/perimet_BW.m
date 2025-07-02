function [BW_perimeter] = perimet_BW(BW_inicial)

% Given a singular binary object, get its perimeter.
%
%
% (CAT)
% Donat un objecte binari singular, obté el perímetre del mateix.
%
%
% Variables
%   input
%       .BW_inicial : Imatge binària inicial.
% 
%   output
%       .BW_perimeter : Imatge binària sols perimetre de la mateixa, final.
%
% Exemple
%
%
% See also
%

% START FUNCTION

% Busquem punts perimetrals
[boundaries, ~] = bwboundaries(BW_inicial); % Elapsed time is 0.010365 seconds.

% Superficial points
superf_points = boundaries{1};

% A imatge
ind = sub2ind(size(BW_inicial),superf_points(:, 1), superf_points(:, 2));
BW_perimeter = false(size(BW_inicial));
BW_perimeter(ind) = true;
%imshow(BW_perimeter)


% END FUNCTION


end