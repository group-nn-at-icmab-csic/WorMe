function determina_path_def(path_definit)

%Determines the program path from its definition.
% 
% 
% See also
% path_determination in WorMe_length_determination_v2_17 (local function)
% split_string_n

% INICI FUNCIÓ

    addpath(genpath(path_definit));
    cd(path_definit);
    pwd;
    cd;


% FINAL FUNCIÓ

end