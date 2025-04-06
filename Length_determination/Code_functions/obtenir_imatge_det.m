function [imageArray_resultapp_origin, baseFileName_origin, fullFileName_origin] = obtenir_imatge_det(nom_im_modif_unic, carpeta_input)

% -Funció especial per a app-: Donada una carpeta i un nom, s'obté la imatge que coincideix amb el nom determinat.
% El nom ha de ser sense .file

% __mostra imatge binaria en colors__
% A partir del nom de la imatge original, s'obté la posició en que aquesta es troba de la carpeta (per coincidència), i d'allà s'obté la imatge.
% nom_imatge_original = string(separar_puntfile(nom_imatge_in)); %app.Label_nomimatge.Text;
% split_nom = split(nom_imatge_original, "_skel");
% nom_im_modif_unic = split_nom(1);

%carpeta_output_principal = app.carpeta_output_results_principal.Text;
%carpeta_input = strcat(carpeta_output_principal, "\Processades\Conjunt_BW");

% Lectura noms imatges i imatge
[theFiles_imresult_original] = lectura_imatges_carpeta_estr(carpeta_input); % Lectura imatges

n_original = 0;

control_correct1 = true;

for n_imoriginal = 1:length(theFiles_imresult_original)                
    % Obtenim el nom de l'arxiu
    nom_ex = theFiles_imresult_original(n_imoriginal).name;
    [nom_im_orig_unic, ~] = separar_puntfile(nom_ex);

    % Comparació dels noms
    if strcmp(nom_im_modif_unic, nom_im_orig_unic)
        n_original = n_imoriginal;
        control_correct1 = false;
    end
end

if control_correct1
    f = msgbox('No coincidence', 'Error','error');
end

% Imatge
baseFileName_origin = theFiles_imresult_original(n_original).name;
fullFileName_origin = fullfile(theFiles_imresult_original(n_original).folder, baseFileName_origin);
imageArray_resultapp_origin = imread(fullFileName_origin); % Imatge inicial
% ___________ %


end
