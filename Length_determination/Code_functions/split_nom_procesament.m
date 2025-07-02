function [procesament_ara_nom, procesament_ara_valor] = split_nom_procesament(procesament_ara)

% A split is generated from "(", so the name and value within () is obtained.
% If there are no (), it returns false.

procesament_ara_split = strsplit(procesament_ara, "(");

if length(procesament_ara_split) > 1
    % There is a '(', so we can obtain the numeric value.
    procesament_ara_nom = procesament_ara_split{1};
    
    % Split the second part
    procesament_ara_split_2 = procesament_ara_split{2};
    procesament_ara_split_2_split =  strsplit(procesament_ara_split_2, ")");
    
    % Value processing
    procesament_ara_valor = str2double(procesament_ara_split_2_split{1});
else
    procesament_ara_nom = procesament_ara;
    procesament_ara_valor = false;
end

end
