function time_ex_function(function_ex)

% NO FUNCIONA: no s'agafa la funcio. exemple: time_ex_function(pause(0.1))
% Determina el temps que tarda en executar-se una funció. 
% S'ha de definir la funció com a tal.
% 
%
% Variables:
% function_ex  : funció a determinar el temps.
%               : exemple: time_ex_function(2+2)
%               : exemple: time_ex_function(numel(find(bwmorph(BW_large_skel_1, 'endpoints'))))
%               : no funciona: time_ex_function(asdf = numel(find(bwmorph(BW_large_skel_1, 'endpoints'))))
%
% See also
% tic

tictoc = []; 
for nm = 1:50; tic; 
    % Funcio
    % _____________________________________________________________________
    %pause(0.001);
	function_ex
    % _____________________________________________________________________
        
    tictoc = [tictoc, toc];
end

% Dades memoria
[userview, systemview] = memory;
GB_RAM_used = round(userview.MemUsedMATLAB/(10^9), 1);
mean(tictoc)

meantictoc = mean(tictoc);
log_meantictoc = log10(meantictoc);

if log_meantictoc < 0
    sprintfNotacio = strcat("%.", string(ceil(abs(log_meantictoc))+2), "f");
else
    sprintfNotacio = strcat("%", string(ceil(abs(log_meantictoc))+2), ".2f");
end

disp(strcat("Elapsed time is: ", sprintf(sprintfNotacio, meantictoc), " seconds")); disp(strcat("from 50 iterations in ", string(GB_RAM_used), "Gb of RAM memory used"))
% disp(strcat("Elapsed time is: ", string(meantictoc))); disp(strcat("from 50 iterations in ", string(GB_RAM_used), "Gb of RAM memory"))




end