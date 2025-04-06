function crear_txt(arxiu_text_output, array_introduir)

% Es crea un arxiu de text amb un array 1x2, amb delimitador ";".

% Guardar l'arxiu output de dades
fid = fopen(arxiu_text_output,'w');
fprintf(fid,'%s \n',strcat(string(array_introduir(1, 1)), ";", string(array_introduir(1, 2))));
fclose(fid);

drawnow; % Force display to update immediately.


end