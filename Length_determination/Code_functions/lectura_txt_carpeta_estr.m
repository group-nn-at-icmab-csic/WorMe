function [theFiles] = lectura_txt_carpeta_estr(myFolder)

% Donada una carpeta, determinada per exemple en uigetdir(), ex: C/User/etc..., es retorna una estructura dels arxius (funció dir) d'aquesta.
% Està orientat a que els arxius siguin de text.
%
% See also
% lectura_imatges_carpeta_estr

% INICI FUNCIO

%GET A ALL IMAGE FILES LIST
% Get a list of all files in the folder with the desired file name pattern.


% _Varis formats d'imatge_

% Obtenir més d'un arxiu d'imatge (ex: jpg i png)
filePattern = fullfile(myFolder, {'*.txt'});

% Cada patró (.jpg, .png, etc...) genera un tipus de lectura diferent
% (filePattern). Llaavors es veu si hi ha arxius d'aquest tipus (dir), i si
% n'hi ha o no, s'integra a theFiles.

% Per cada patró
for n_filep = 1:length(filePattern)
        
    % Obtenció estructura del patró
    filePattern_tot = filePattern{n_filep};
    %filePattern_tot
    struct_fileP = dir(filePattern_tot);

    
    if n_filep == 1
        theFiles = struct_fileP;
    else
            if isempty(theFiles)
                % Si és vuit l'arxiu theFiles (no s'ha obtingut imatges d'aquest tipus anteriors).
                theFiles = struct_fileP;
            else
                % S'uneixen les estructures
                theFiles = cell2struct([struct2cell(theFiles),struct2cell(struct_fileP)],fieldnames(theFiles),1);

                
            end
    end
end
   

% % _Un format d'imatge_
% filePattern = fullfile(myFolder, '*.jpg'); % Change to whatever pattern you need.
% theFiles = dir(filePattern);

% FINAL FUNCIÓ

% % VELL ANTERIOR A PARTIR D'AQUI
% filePattern = fullfile(myFolder, {'*.jpg', '*.png'}); %← Més d'un tipus
% 
% conta_mes_un = 1; % contador per alertar si hi ha mes d'un arxiu d'imatge
% 
% % Per cada patró
% for n_filep = 1:length(filePattern)
%     
%     % Obtenció estructura del patró
%     filePattern_tot = filePattern{n_filep};
%     %filePattern_tot
%     struct_fileP = dir(filePattern_tot);
%     
%     if isempty(struct_fileP)
%         %return
%     else
%         if n_filep == 1
%             theFiles = struct_fileP;
%             conta_mes_un = conta_mes_un + 1;
%         else
%             if n_filep == conta_mes_un
%                % S'uneixen les estructures
%                 theFiles = cell2struct([struct2cell(theFiles),struct2cell(struct_fileP)],fieldnames(theFiles),1);
%                 conta_mes_un = conta_mes_un + 1;
%             end
%         end
%     end
% end
% 
% % % _Un format d'imatge_
% % filePattern = fullfile(myFolder, '*.jpg'); % Change to whatever pattern you need.
% % theFiles = dir(filePattern);
% 
% % FINAL FUNCIÓ


end