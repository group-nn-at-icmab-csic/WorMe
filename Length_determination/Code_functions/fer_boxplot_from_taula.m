function [array_dades_tot, array_repetits_categories_categorical] = fer_boxplot_from_taula(table_lect)

% Donada una taula tipu:
%     x0hAmanda    x0hWM     x24hCAmanda    x24hCWM    x48hCAmanda
%     _________    ______    ___________    _______    ___________
% 
%      172.72      166.03      399.06       246.29       729.85   
%      159.78       145.7       338.1       251.41       703.34   
%      164.08      132.06      474.77       361.38       663.11   
%      151.59      140.59      348.25        434.2       753.32   
%       156.9      171.38      365.26       363.36       607.73 
%
% es tornen les dades per a que es pugui fer un boxplot d'aquestes, de la
% forma:
% boxchart(array_repetits_categories_categorical, array_dades_tot_obt)
      
variables_names = table_lect.Properties.VariableNames;

talbe_lect_array = table2array(table_lect);

% Creem array amb les variables (passem de cell a array)
variable_names_array = [];
for names = variables_names
    if isempty(variable_names_array)
        variable_names_array = [string(names{1})];
    else
        variable_names_array(end+1) = string(names{1});
    end
    
end



% fem en elements
array_repetits_categories = [];
for n_posi = 1:length(variables_names)
    
    elems_repets = repelem(variable_names_array(n_posi), length(rmmissing(talbe_lect_array(:, n_posi))));
    
    % Afegim al array
    if isempty(array_repetits_categories)
        array_repetits_categories = [elems_repets];
    else
        array_repetits_categories = [array_repetits_categories, elems_repets];
    end
end



% Passem la matriu a una llista:
array_dades_tot = [];
[~, cols_elm] = size(talbe_lect_array);
for cada_elm = 1:cols_elm
    if isempty(array_dades_tot)
        array_dades_tot = [rmmissing(talbe_lect_array(:,cada_elm))]';
    else
        array_dades_tot = [array_dades_tot, rmmissing(talbe_lect_array(:,cada_elm))'];
    end
end


array_repetits_categories_categorical = categorical(array_repetits_categories);

end