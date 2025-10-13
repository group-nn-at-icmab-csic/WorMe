function [n_yes, n_no] = app_interf_table_contar_pos(app)

% Reads the data and returns the number of worms "yes" and the
% number of worms "no". Used for counting.

% START FUNCTION

n_yes = 0;
n_no = 0;
% n_empty = 0;

taula_operar = app.table_main_sel; % Main table

% taula_operar

% Empty table
varNames = {'Image','nModif','ModifTable'};
taula_filtrada = table('Size',[0, 3],'VariableTypes',{'string', 'double', 'cell'},'VariableNames',varNames);

% Different image names
noms_imgs = unique(taula_operar.Image);

% For each type of image
for n_nom_img = 1:numel(noms_imgs)
    nom_img_n = noms_imgs(n_nom_img); % Name of each image

    % We filter the table by the name of the image:
    patients_tabla_name = taula_operar(strcmp(taula_operar.Image, nom_img_n), :);
    % Now we only have tables with that name.

    % We take the row with the highest value
    [maxValue, maxIndex] = max(patients_tabla_name.nModif); % maximum value

    % Obtain the row with the maximum value
    patients_tabla_name_unic = patients_tabla_name(maxIndex, :);

    % We add the table to the total table:
    taula_filtrada = [taula_filtrada; patients_tabla_name_unic];
end
% Up to here we have the table with the highest values.

% taula_filtrada

% Now we “open” the data of the table, and check which have “yes” and which have
% “no”:
is_Celeg = [];
for nh_table = 1:height(taula_filtrada)
    is_Celeg = [is_Celeg; taula_filtrada.ModifTable{nh_table}.IsCeleg];
end

n_yes = sum(count(is_Celeg, "yes"));
n_no = sum(count(is_Celeg, "no"));
% n_empty = sum(count(is_Celeg, "empty"));

% END FUNCTION

end