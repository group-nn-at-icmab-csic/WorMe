%% Convert the matrix to a 3 dimensional matrix
function [matriu_3] = to_3(matriu_1)
    matriu_3 = cat(3, matriu_1, matriu_1, matriu_1);
end