function [dir_carpetes_tot_sorted, date_sorted, dir_carpetes_tot, data_carpetes] = obtenir_nom_carpetes(results_dir)

% Obté el nom de les carpetes 

% Variables
%
%   input
%       results_dir : carpeta la qual es vol obtenir el nom de les carpetes
%
%   output
%       dir_carpetes_tot_sorted : carpetes ordenades per data
%       date_sorted : data de les carpetes, ordeandes
%       dir_carpetes_tot : carpetes ordenades per nom
%       data_carpetes: data carpetes ordenades per nom
%
%       
% See also
% cell_insert_valors


% INICI FUNCIÓ



dir_carpetes = dir(results_dir);

dir_carpetes_tot = {};
data_carpetes = {};
for n_dir = 1:length(dir_carpetes)

    carpeta_nom = dir_carpetes(n_dir).name;


    if carpeta_nom ~= "." && carpeta_nom ~= ".." && dir_carpetes(n_dir).isdir
        dir_carpetes_tot = cell_insert_valors(dir_carpetes_tot, carpeta_nom);
        data_carpetes = cell_insert_valors(data_carpetes, dir_carpetes(n_dir).date);
    end
end

% Ordenem per data
[date_sorted, indxsort] = sort(datetime(data_carpetes));

dir_carpetes_tot_sorted = dir_carpetes_tot(indxsort);


% FINAL FUNCIÓ



end