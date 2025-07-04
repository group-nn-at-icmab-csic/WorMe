function [BW_perimeter] = perimet_BW(BW_inicial)

% Given a singular binary object, get its perimeter.
%
%
% Variables
%   input
%       .BW_inicial : Initial binary image
% 
%   output
%       .BW_perimeter : Perimeter of binary object.
%
% Exemple
%
%
% See also
%

% START FUNCTION

% Find perimeter points
[boundaries, ~] = bwboundaries(BW_inicial); % Elapsed time is 0.010365 seconds.

% Superficial points
superf_points = boundaries{1};

% Image
ind = sub2ind(size(BW_inicial),superf_points(:, 1), superf_points(:, 2));
BW_perimeter = false(size(BW_inicial));
BW_perimeter(ind) = true;
%imshow(BW_perimeter)


% END FUNCTION


end