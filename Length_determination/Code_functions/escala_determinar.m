function [escala_imatge] = escala_determinar(imatge_crop_josep, valor_nums)

    % GUI to determine the scale of an image.

    % START FUNCTION

    % Determine if we want thath the letters are readed.
    operacio_lletres = false;
        
    % __mini_function__ Determine pixels
    
    % Given an initial image, the scale of this is determined in an
    % interactive way, either by entering the scale value or
    % determining it from the image.
    
    % Initially, the value will be determined in micrometers, as well as the
    % value of the image will also be in micrometers.
    
    % variables:
    % input: initial image
    % interactive: enter scale; yes/no{image select cropping}
    % output: image scale [image_scale]
    
    % 'key' to exit the while, when everything is correct. Otherwise, the data is
    % entered again.

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
                    
                    % If the result contains a comma ',' return to input
                    % data
                    
                   
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
    
            
        % SELECT IMAGE
        elseif answer == "Select automatically"

            % App app_escala_auto
            carpeta_out_app = "Results_out\Internal_code_files";
            waitfor(app_escala_auto(imatge_crop_josep, carpeta_out_app))            

            
            % Asssign the value of escala_determinar
            
            % Read text 
            arxiu_text_output = "Results_out\Internal_code_files\escale_line.txt";
            [escala_imatge_prov, ~] = llegir_text_delimitadors(arxiu_text_output, ";");
            escala_imatge = str2double(escala_imatge_prov(2));
            
            % Output
            corrector_tot_be  = false;


        elseif answer == "Select by a line"
            
            carpeta_out_app = "Results_out\Internal_code_files";
            waitfor(app_escala_linia(imatge_crop_josep, carpeta_out_app))
            
                      
            % Assign the value of escala_determinar
            
            % Read text
            arxiu_text_output = "Results_out\Internal_code_files\escale_line.txt";
            [escala_imatge_prov, ~] = llegir_text_delimitadors(arxiu_text_output, ";");
            escala_imatge = str2double(escala_imatge_prov(2));
            
            % output
            corrector_tot_be  = false;

            
        % TO LEAVE
        else
            %waitfor(msgbox('Sisplau, esculli una opció'));
            answer_sortida = questdlg('Do you want to exit?', '', 'Yes','No', 'No');
            % Handle response
            switch answer_sortida
                case 'Yes'
                    answer_sortida = 1;
                case 'No'
                    answer_sortida = 0;
            % If want to quit, true
                    
            end
            
        
        % If the answer is "Yes", it is true (1) and exits (corrector all be
        % false)            
            if answer_sortida
                corrector_tot_be = 0;
            else
                corrector_tot_be = 1;
            end
            
            
        end
        
        
    
    end

  % Show the scale in a final box
%msgbox(strcat('Scale:', " ", num2str(image_scale), ' pixels / unit'));
% Note: waitfor() has been removed
    
    
    
%     disp("OUT OF THE PROGRAM")
%     escala_imatge
   
    
    % FINAL OF THE FUNCTION

    
end