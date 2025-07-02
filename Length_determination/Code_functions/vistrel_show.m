function vistrel_show(Strel_AAA)

% Visualizes a Strel (example: SA_AAA = strel('line', 10, 75))
% in an image made from zeroes, to be able to see it properly.
% Now, however, it is shown.
%
% See also:
% vistrel
% vistrel_2

SA_img = Strel_AAA.Neighborhood;
size_SA = size(SA_img);

im_zeros_SA = zeros(size_SA(1)+2, size_SA(2)+2);

im_zeros_SA(2:end-1,2:end-1) = SA_img;

imshow(im_zeros_SA, 'InitialMagnification','fit')

end