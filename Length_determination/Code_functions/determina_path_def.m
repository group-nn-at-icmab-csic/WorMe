function determina_path_def(path_definit)

%Determines the program path from its definition.
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