function resta_dades_coincarx(arxiu_text_output_manually, n_vegades_add, nom_posicio_a_intro)

% Funció per a la app, del botó return.
% Lectura dades existents, i restem una línia.
% Si no hi ha hagut cambis, no es resta cap. Es resta en funció al
% comptador d'imatges guardades, proporcional al nombre de files+1 (primer
% és encapçalament).
%
% Variables
% n_vegades_add  : Vegades que s'ha afegit l'arxiu. Discriminador de 0 vegades.
% numeric_val : contador d'imatges que hi ha. Ex: imatge 1, 2, 3... etc.
%
%
% Variable cell de mostra
%      asdf = [{'imatge'                }    {'llargada '};
%     {'P1011629_skel_00003_01'}    {'261.4721 '};
%     {'P1011630_skel_00004_01'}    {'319.8656 '}]
%
% Variables exemple MATLAB
% arxiu_text_output_manually = "C:\Users\Josep TOSHIBA\Desktop\Length determination v2_7\Results_out\20220329_1316_Input_images_Amanda_poques\Manually\dades_output.txt";
% n_vegades_add = 69;
% 
% nom_posicio_a_intro = "P1011624_skel_00001_01";
%
%
% See also
% introduir_dades_posvar

if n_vegades_add == 0
    % No hi ha dades
    % No fem res. No restem (no es pot)
else
    % Hi ha dades.
    % Restem la última línia

    % Lectura dades existents
    cell_crua_dades = llegir_text_delimitadors(arxiu_text_output_manually, ";");

    [size_llargada, ~] = size(cell_crua_dades);

    % Busquem la posició del nom:
    fila_on_introduir = false;
    for cada_fila = 1:length(cell_crua_dades)
        % Si coincideixen
        if strcmp(cell_crua_dades{cada_fila, 1}, nom_posicio_a_intro)
            % Guardem la fila
            fila_on_introduir = cada_fila;
        end
    end
    
    % Possible error no coincidència valor
    if ~isnumeric(fila_on_introduir)
        % Si no hi ha arxiu no es fa re-write
        %msgbox('No coincidència string', 'Error','error');
        %error("en f'introduir_dades_posvar': No coincidència string")
    
    else


        % Guardar l'arxiu output de dades
        fid = fopen(arxiu_text_output_manually,'w');
        for var_out_dades = 1:size_llargada
            % Si la posicio del write és la que volem:
            if var_out_dades == fila_on_introduir        
                % No introduim dades
                strcat(cell_crua_dades{var_out_dades, 1}, ";", cell_crua_dades{var_out_dades, 2})
            else
                fprintf(fid,'%s \n',strcat(cell_crua_dades{var_out_dades, 1}, ";", cell_crua_dades{var_out_dades, 2}));
            end

        end
        fclose(fid);

        drawnow; % Force display to update immediately.

    end

%     % VELL
%     cell_dades_mfilt_nou = cell_dades_mfilt(1 : end-1, :);
%     
%     [size_llargada, ~] = size(cell_dades_mfilt_nou);
%     % Write
%     % Guardar l'arxiu output de dades
%     fid = fopen(arxiu_text_output_manually,'w');
%     for var_out_dades = 1:size_llargada
%       fprintf(fid,'%s \n',strcat(cell_dades_mfilt_nou{var_out_dades, 1}, ";", cell_dades_mfilt_nou{var_out_dades, 2}));
%     end
%     fclose(fid);
% 
%     drawnow; % Force display to update immediately.

end



end