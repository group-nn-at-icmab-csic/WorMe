function [BW_skel_final_unic] = large_skel_iter(BW_skel_image)

% Funció chapuzilla, 
% Aplica large_skel() de forma que si no es resolt el large skel, i queda
% alguna branca, es torna a generar la funció de large_skel.
%
%
% See also
% large_skel

% INICI FUNCIÓ

% Aplicació de la funció lare_skel
[BW_skel_final_unic] = large_skel(BW_skel_image);

% Determinem els endpoits i branchpoints
BWskel_endpoints = numel(find(bwmorph(BW_skel_final_unic, 'endpoints'))); % Elapsed time is: 0.000943 seconds ; 50 iterations in 4.2Gb of RAM memory used
BWskel_branchpoints = numel(find(bwmorph(BW_skel_final_unic, 'branchpoints'))); % Elapsed time is: 0.00450 seconds ; 50 iterations in 4.2Gb of RAM memory used

% Si hi ha més de 2 endpoints, o bé els branchpoints és major a 0:
if ~isequal(BWskel_endpoints, 2) || ~isequal(BWskel_branchpoints, 0)
    %disp("f'large_skel_iter': BWskel more than 2 endpoints or 0 branchpoint after first large_skel function application.")
    
    % Fem loop on a cada es torna a fer la funció.
    % Si resulta que la funció torna un esquelet amb 2 endpoints i 0
    % branchpoints, es surt
    for n_loops = (1:5)
        % n_loops
        [BW_skel_final_unic] = large_skel(BW_skel_final_unic);
        
        % Determinem els endpoits i branchpoints
        BWskel_endpoints = numel(find(bwmorph(BW_skel_final_unic, 'endpoints')));
        BWskel_branchpoints = numel(find(bwmorph(BW_skel_final_unic, 'branchpoints')));

        if isequal(BWskel_endpoints, 2) && isequal(BWskel_branchpoints, 0)
            break
        end
    end
else
    % disp("2 endp and 0 branchp after first")
end
    

% FINAL FUNCIÓ

end
