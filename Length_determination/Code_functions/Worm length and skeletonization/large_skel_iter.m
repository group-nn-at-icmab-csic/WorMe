function [BW_skel_final_unic] = large_skel_iter(BW_skel_image)

% Applies large_skel() so that if the large skel is not resolved, and
% some branch remains, the large_skel function is generated again.
%
%
% See also
% large_skel

% START FUNCTION

% Apply of large_skel function
[BW_skel_final_unic] = large_skel(BW_skel_image);

% Determine the endpoints and branchpoints
BWskel_endpoints = numel(find(bwmorph(BW_skel_final_unic, 'endpoints'))); % Elapsed time is: 0.000943 seconds ; 50 iterations in 4.2Gb of RAM memory used
BWskel_branchpoints = numel(find(bwmorph(BW_skel_final_unic, 'branchpoints'))); % Elapsed time is: 0.00450 seconds ; 50 iterations in 4.2Gb of RAM memory used

% If there is more than 2 endpoints, or branchpoint is bigger than 0: 
if ~isequal(BWskel_endpoints, 2) || ~isequal(BWskel_branchpoints, 0)
    %disp("f'large_skel_iter': BWskel more than 2 endpoints or 0 branchpoint after first large_skel function application.")
    
% We loop where each time the function is repeated.
% If the function returns a skeleton with 2 endpoints and 0
% branchpoints, we exit
    for n_loops = (1:5)
        % n_loops
        [BW_skel_final_unic] = large_skel(BW_skel_final_unic);
        
        % Determine endpoits i branchpoints
        BWskel_endpoints = numel(find(bwmorph(BW_skel_final_unic, 'endpoints')));
        BWskel_branchpoints = numel(find(bwmorph(BW_skel_final_unic, 'branchpoints')));

        if isequal(BWskel_endpoints, 2) && isequal(BWskel_branchpoints, 0)
            break
        end
    end
else
    % disp("2 endp and 0 branchp after first")
end
    

% END FUNCTION

end
