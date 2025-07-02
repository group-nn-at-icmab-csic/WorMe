function [dades_imatge] = ficar_marges(BW_verticalized_marges)
% Given a 'verticalized' binary image, define its sides and plot a line on them.

% imshow(BW_verticalized_marges);

num_cols = sum(BW_verticalized_marges, 2);
finding_num_cols = find(num_cols);
primer_valor = finding_num_cols(1);
ultim_valor = finding_num_cols(length(finding_num_cols));

imatge_zeros = zeros(size(BW_verticalized_marges));
size(imatge_zeros);
size(BW_verticalized_marges);

imatge_zeros(primer_valor, :) = 1;
imatge_zeros(ultim_valor, :) = 1;

dades_imatge = imshow(imoverlay(BW_verticalized_marges, imatge_zeros, "r"));
dades_imatge = dades_imatge.CData;

% imshow(dades_imatge)

end
