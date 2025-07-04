function sumar_un_a_txt_valor_string(arxiu_text_det, nom_det_funcio)

% Given a text file, where the name and value are described in two columns respectively, 
% 1 is added to the value in the row whose name has been determined,
% and if it does not exist, it is created.
%
% This function goes together with f'write_text_array', since with
% f'write_text_array' the text file with the desired arrays is created.
% It also goes together with the function f'obtenir_de_txt_valor_string'.
%
% Variables
% nom_det_funcio : name whose value we want to add 1 to in a text file.
% arxiu_text_det : name of the text file we want to analyze.
%
% _Example function_
%
% % Example data
% arxiu_text_det = "asdf.txt";
% 
% dades_write = []
% 
% dades_write = [
%     "P1011624_skel_00001_01"    "610.1569";
%     "P1011629_skel_00003_01"    "261.4721";
%     "P1011630_skel_00004_01"    "319.8656";
%     "P1011655_skel_00005_01"    "208.8975";
%     "P1011655_skel_00005_03"    "205.9703"]
% 
% write_text_array(arxiu_text_det, dades_write, ";")
% 
% nom_det_funcio = "P1011629_skel_00003_01";
%
% % Example of function execution
%  arxiu_text_det = "asdf.txt";
% nom_det_funcio = "P1011629_skel_00003_01";
% sumar_un_a_txt_valor_string(arxiu_text_det, nom_det_funcio)
%
% % Example of function execution 2
% arxiu_text_det = "asdf2.txt";
% nom_det_funcio = "P1011629_skel_00003_01";
% sumar_un_a_txt_valor_string(arxiu_text_det, nom_det_funcio)

% See also:
% write_text_array, llegir_text_delimitadors, obtenir_de_txt_valor_string

% START FUNCTION

if ~isfile(arxiu_text_det)
    llegit_text_cell = {};
else
    llegit_text_cell = llegir_text_delimitadors(arxiu_text_det, ";");
end

es_present_valor = false;



% If the file does not contain the name, add it with value 1.
if isempty(llegit_text_cell)
    llegit_text_cell = { nom_det_funcio,  '1' };
else
    % If not empty, add 1 to the current value.
    
    % Read the data
    [nfiles, ~, ~] = size(llegit_text_cell);
    for cada_fila = 1:nfiles
        nom_de_fila = llegit_text_cell{cada_fila,1};
        valor_de_fila = llegit_text_cell{cada_fila,2};
        if strcmp(nom_de_fila, nom_det_funcio)
            es_present_valor = true;
            valor_de_fila_out = str2double(valor_de_fila) +1;
            llegit_text_cell{cada_fila,2} = string(valor_de_fila_out);
        end
    end
    
end


% Then do a write

% Save the file data output 
fid = fopen(arxiu_text_det,'w');
[nfiles, ~, ~] = size(llegit_text_cell);
for var_out_dades = 1:nfiles
    fprintf(fid,'%s \n',strcat(llegit_text_cell{var_out_dades, 1}, ";", llegit_text_cell{var_out_dades, 2}));
end
fclose(fid);

drawnow; % Force display to update immediately.



% END FUNCTION

end