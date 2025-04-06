function [escala_imatge] = escala_determinar(imatge_crop_josep, valor_nums)

    % GUI per a determinar la escala d'una imatge.

    % INICI FUNCIÓ

    % detemrinem si volem que es llegeixin les lletres.
    operacio_lletres = false;
    
    % __mini_funcio__ Determinar píxels
    
    % Donada una imatge inicial, es determina l'escala d'aquesta de manera
    % interactiva, ja sigui introduïnt el valor de l'escala o bé
    % determinant-lo per la imatge.
    
    % En un principi, el valor serà determinat en micrometres, així com el
    % valor de la imatge serà també en micrometres.
    
    % variables:
    % input: imatge inicial
    % interactiu: introduccio escala ; si/no{imatge seleccio cropping}
    % output: escala imatge [escala_imatge]
    
    % 'clau' per a sortir del while, quan tot estigui correcte. Sinó es torna a
    % introduïr les dades.
    corrector_tot_be = 1; %<- true
    
    
    if ~exist('valor_nums','var')
        valor_nums = '';
    end
    
    
    while corrector_tot_be
    
        % - Box Tipus d'introducció dades -
%         answer = questdlg('\fontsize{15} Scale determination options:', ...
%         	'Scale determination', ...
%         	"Select automatically", "Select by a line", 'Introduce numerical value', 'Introduce numerical value'); %"Draw a line",
        answer = questdlg('\fontsize{15} Scale determination options:', ...
        	'Scale determination', ...
        	"Select automatically", "Select by a line", 'Introduce numerical value', struct('Default','Introduce numerical value','Interpreter','tex')); %"Draw a line",        
        % Handle response
        switch answer
            case 'Select automatically'
                disp("has seleccionat: Select automatically")
            case 'Select by a line'
                disp("has seleccionat: Select by a line")
%             case 'Draw a line'
%                 disp("has seleccionat: Draw a line")
            case 'Valor numeric'
                disp('has seleccionat: Valor numeric')
                
                
        end
        
        %answer;
        
        % INTRODUIR NUMERIC
        if answer == "Introduce numerical value"
            
            corrector_tot_be_numeric = 1; %<- true, no surt del bloc.
            while corrector_tot_be_numeric
                
                try
                    prompt = {'Enter matrix size:'};
                    dlgtitle = 'Input';
                    dims = [1 25];

                    definput = {valor_nums};
                    
                    answer_introd = inputdlg(prompt,dlgtitle,dims,definput);
                    
                    % Si el resultat conté una coma ',' retorna a introduïr
                    % dades
                    
                   
                    if contains(answer_introd{1}, ",")
                        waitfor(msgbox('Invalid Value', 'Error','error'));
                        break
                        
                    end
                    escala_imatge = str2num(answer_introd{1});
                    
                    if isempty(escala_imatge)
                        waitfor(msgbox('Invalid Value', 'Error','error'));
                    else
                        corrector_tot_be_numeric = 0;
                        corrector_tot_be = 0;
    
                    end
                    
                catch
                    corrector_tot_be_numeric = 0;
                    waitfor(msgbox('Invalid Value', 'Error','error'));
    
                    
                end
                
            end
    
            
        % SELECCIONAR IMATGE
        elseif answer == "Select automatically"

            % App app_escala_auto
            carpeta_out_app = "Results_out\Internal_code_files";
            waitfor(app_escala_auto(imatge_crop_josep, carpeta_out_app))            

            
            % Assignar el valor de escala_determinar
            
            % Llegir text
            arxiu_text_output = "Results_out\Internal_code_files\escale_line.txt";
            [escala_imatge_prov, ~] = llegir_text_delimitadors(arxiu_text_output, ";");
            escala_imatge = str2double(escala_imatge_prov(2));
            
            % Sortida
            corrector_tot_be  = false;
%                 
%             if operacio_lletres
%                 % -variable lletres- BW_bwa_lletra
%                 BW_bwa_lletra = BW_bwa - BW_bwa_metro;
%                 imshow(BW_bwa_lletra)
% 
%                 % Operació lletres %
% 
% 
% 
%                 % A avantpriori, s'ha de definir el Computer Vision Toolbox OCR
%                 % language, per a poder detectar les lletres gregues, donat que la
%                 % versió predeterminada sols és en anglès i japonès.
% 
%                 %visionSupportPackages 
% 
%                 % Perform OCR.
%                 results = ocr(BW_bwa_lletra, "Language","Catalan");
%                 %results = ocr(BW_bwa_lletra, "Language","Greek");
% 
% 
%                 % Display one of the recognized words.
%                 word = results.Words{1};
% 
%                 % Seleccionem sols el valor numèric
%                 word_num = regexp(word,'[0-9]','match');
%                 word_num = strcat(word_num);
%                 word_num = [word_num{:}];
%                 word_num = str2num(word_num);
% 
%             else
%                 % Si el valor numèric no es determina automàticament, fem
%                 % que s'introdueixi.
%                 imshow(BW_bwa_metro_BB)
%                                
%                 %Quadre diàleg
%                 prompt = "Determine the scale units value:";
%                 dlgtitle = 'Input';
%                 dims = [1 35];
%                 definput = {''};
%                 answer = inputdlg(prompt,dlgtitle,dims,definput);
% 
%                 word_num = str2double(answer{1});
%             end
            

        elseif answer == "Select by a line"
            % ññññ
            carpeta_out_app = "Results_out\Internal_code_files";
            waitfor(app_escala_linia(imatge_crop_josep, carpeta_out_app))
            
            
            % ÑÑÑ Llegir el valor
            
            % Assignar el vaor de escala_determinar
            
            % Llegir text
            arxiu_text_output = "Results_out\Internal_code_files\escale_line.txt";
            [escala_imatge_prov, ~] = llegir_text_delimitadors(arxiu_text_output, ";");
            escala_imatge = str2double(escala_imatge_prov(2));
            
            % Sortida
            corrector_tot_be  = false;

            
        % SORTIR
        else
            %waitfor(msgbox('Sisplau, esculli una opció'));
            answer_sortida = questdlg('Do you want to exit?', '', 'Yes','No', 'No');
            % Handle response
            switch answer_sortida
                case 'Yes'
                    answer_sortida = 1;
                case 'No'
                    answer_sortida = 0;
            % Si es vol sortir, true
                    
            end
            
            % Si resposta és "Si", és true (1) i es surt (corrector tot be
            % false)
            if answer_sortida
                corrector_tot_be = 0;
            else
                corrector_tot_be = 1;
            end
            
            
        end
        
        
    
    end
    
    % Mostrar la escala en un box final
    %msgbox(strcat('Escala:', "  ", num2str(escala_imatge), '  pixels / unit'));
    % Nota: s'ha tret el waitfor()
    
    
    
    
%     disp("OUT OF THE PROGRAM")
%     escala_imatge
   
    
    % FINAL FUNCIÓ

    
end