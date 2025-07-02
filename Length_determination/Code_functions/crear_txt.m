function crear_txt(arxiu_text_output, array_introduir)

% Create a text file with a 1x2 array, with ";" delimiter.

% Save the output data file
fid = fopen(arxiu_text_output,'w');
fprintf(fid,'%s \n',strcat(string(array_introduir(1, 1)), ";", string(array_introduir(1, 2))));
fclose(fid);

drawnow; % Force display to update immediately.


end