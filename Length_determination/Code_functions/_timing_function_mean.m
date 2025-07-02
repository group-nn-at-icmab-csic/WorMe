% NOTA: 1. Change the function for the opreation 
% 2. To do Ctrl + A and copy the comandment line 
tictoc = []; for nm = 1:50; tic; 

    % Function
    % _____________________________________________________________________
       ispc

% _____________________________________________________________________
        
tictoc = [tictoc, toc]; end;
[userview, systemview] = memory; GB_RAM_used = round(userview.MemUsedMATLAB/(10^9), 1); mean(tictoc); meantictoc = mean(tictoc); log_meantictoc = log10(meantictoc);
if log_meantictoc < 0; sprintfNotacio = strcat("%.", string(ceil(abs(log_meantictoc))+2), "f"); else; sprintfNotacio = strcat("%", string(ceil(abs(log_meantictoc))+2), ".2f"); end
disp(strcat("Elapsed time: ", sprintf(sprintfNotacio, meantictoc), " seconds ; 50 iterations in ", string(GB_RAM_used), "Gb of RAM memory used"));



