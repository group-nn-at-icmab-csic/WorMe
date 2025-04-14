

% COMPROVACIÓ EN APP


%             % Comprovació
%            [S_textscan_table] = app_interf_llegir_main_dades(dir_output);
%            S_textscan_table_comp = app.global_S_textscan_table
% 
%            % Comprovació igualtat
%            % Si el nº d'elements no és el mateix, i si l'ultim element tampoc          
%            if ~(numel(S_textscan_table) == numel(S_textscan_table_comp)) && ~(isequal(S_textscan_table.Bounding(end), S_textscan_table_comp.Bounding(end) ))
%                disp("NOT THE SAME ELEMENTS ARE THE TABLE!!!")
%            end
           

%             % __Descripció temps__ %_contTemps_
% 
%             disp("Lectura cells i filtres")  
%             % Def temps
%             data_time_2 = datetime("now");
%             interval_de_temps_segons = etime(datevec(data_time_2), datevec(data_time_1));
%             app.global_control_temps_1 = [app.global_control_temps_1, interval_de_temps_segons];
% 


%            end           