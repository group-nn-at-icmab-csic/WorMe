function [procesament_ara_nom, procesament_ara_valor] = split_nom_procesament(procesament_ara)

% Es genera un split a partir de "(", de manera que s'obté el nom i el valor de dins
% de (). Si no hi ha () es retorna false.

procesament_ara_split = strsplit(procesament_ara, "(");

if length(procesament_ara_split) > 1
    % Hi ha un '(', per lo que es pot obtenir el valor numeric.
    procesament_ara_nom = procesament_ara_split{1};
    
    % Split segona part
    procesament_ara_split_2 = procesament_ara_split{2};
    procesament_ara_split_2_split =  strsplit(procesament_ara_split_2, ")");
    
    % Valor processament
    procesament_ara_valor = str2double(procesament_ara_split_2_split{1});
else
    procesament_ara_nom = procesament_ara;
    procesament_ara_valor = false;
end

end
