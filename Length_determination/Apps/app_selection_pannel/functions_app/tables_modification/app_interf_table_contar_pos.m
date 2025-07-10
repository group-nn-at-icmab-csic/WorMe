function [n_yes, n_no] = app_interf_table_contar_pos(app)

% Fa una lectura de les dades i retorna el nombre de worms "yes" i el
% nombre de worms "no". Serveix per a contador.


% INICI FUNCIÓ

n_yes = 0;
n_no = 0;
% n_empty = 0;

taula_operar = app.table_main_sel; % Taula principal

% taula_operar


% Taula vuida
varNames = {'Image','nModif','ModifTable'};
taula_filtrada = table('Size',[0, 3],'VariableTypes',{'string', 'double', 'cell'},'VariableNames',varNames);

% Nom diferents imtges
noms_imgs = unique(taula_operar.Image);

% Per cada tipus d'imatge
for n_nom_img = 1:numel(noms_imgs)
    nom_img_n = noms_imgs(n_nom_img); % Nom de cada imatge

    % Filtrem la taula per el nom de la imatge:
    patients_tabla_name = taula_operar(strcmp(taula_operar.Image, nom_img_n), :);
    % Ara nomès tenim taules on hi ha el nom.

    % Agafem la fila que té major valor
    [maxValue, maxIndex] = max(patients_tabla_name.nModif); % valor max

    % Obtain the row with the maximum value
    patients_tabla_name_unic = patients_tabla_name(maxIndex, :);

    % Agreguem la taula a la taula total:
    taula_filtrada = [taula_filtrada; patients_tabla_name_unic];
end
% Fins aqui tenim la taula amb els valors més grans.


% taula_filtrada


% Ara "obrim" les dades de la taula, i mirem quins tenen "si" i quins tenen
% "no":
is_Celeg = [];
for nh_table = 1:height(taula_filtrada)
    is_Celeg = [is_Celeg; taula_filtrada.ModifTable{nh_table}.IsCeleg];
end


n_yes = sum(count(is_Celeg, "yes"));
n_no = sum(count(is_Celeg, "no"));
% n_empty = sum(count(is_Celeg, "empty"));


% FINAL FUNCIÓ

end