function vistrel(Strel_AAA)
    % Example: Strel_AAA = strel('disk', 5);
    % From: https://es.mathworks.com/matlabcentral/answers/368927-how-to-display-the-object-created-with-function-strel
    Strel_AAA.Neighborhood
    image(Strel_AAA.Neighborhood); colormap(gray(2));
end