function appini_guardar_theFiles_txt(theFiles, arxiu_txt_dir_img)

% Guarda el arxiu theFiles obtingut de la lectura de les imatges o carpeta, a un arxiu de text,
% on hi haurà les rutes de cada imatge.
%
%
% Variables
%   input
%       theFiles
%       arxiu_txt_dir_img 
%       .
% 
%   output
%       .
%       .
%       .
%
% Exemple
%
% % _Seleccionem la carpeta_
% carpeta_input = uigetdir();
% 
% % _Lectura de la carpeta d'imatges_
% theFiles = lectura_imatges_carpeta_estr(carpeta_input);
% 
% dir_results_analisis = strcat(app.dir_current, "\Results_out\Analisis_results");
% carpeta_guardar_dades = strcat(dir_results_analisis, "\", app.ListBox.Value); % Carpeta guardat dades
% arxiu_txt_dir_img = strcat(carpeta_guardar_dades, "\", "theFiles.txt"); % Dir arxiu .txt guardar imatges 
%
% See also
%


% INICI FUNCIÓ

for n_img = 1:length(theFiles)
    % Cell amb les dades
    cell_dades_totals = {strcat(theFiles(n_img).folder, "\", theFiles(n_img).name)};
    
    % Write de les dades % 
    write_dades_cell(arxiu_txt_dir_img, cell_dades_totals, "%s", "$")
end

% FINAL FUNCIÓ


end

    