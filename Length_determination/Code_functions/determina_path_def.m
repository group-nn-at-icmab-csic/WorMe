function determina_path_def(path_definit)

% Determina el path del programa a partir de la definició d'aquest.
% 
% 
% See also
% determinacio_path (funció local)
% split_string_n

% INICI FUNCIÓ

    addpath(genpath(path_definit));
    cd(path_definit);
    pwd;
    cd;


% FINAL FUNCIÓ

end