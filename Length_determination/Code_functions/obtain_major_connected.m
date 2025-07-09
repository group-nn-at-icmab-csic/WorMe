function [BW_non_conn] = obtain_major_connected(BW_amb_conexions, num_conexio)

% Donada una imatge binaria, amb diferents objectes conectats (ex: dos
% pixels que es toquen, o es rosen), es retorna la imatge de major area.
% Això serveix per a, d'una imatge binaria, treure tots aquells pixels que
% rosen aquesta, per exemple, que toquen aquesta però que no formen part de
% la imatge.
%
%
% Variables
% num_conexio : Propietat conn de bwconncomp; son els elements conectats (veure doc bwconncomp). exemple: 4. 
%
%
% Temps de processament
% tic; [BW_non_conn_major] = obtain_major_connected(BW_edges_final_p, 4);toc
% Elapsed time is 0.017739 seconds.
%
% See also
% bwconncomp
% labelmatrix

BW_conn_comp = bwconncomp(BW_amb_conexions, num_conexio);

% Fem matriu amb els diferents elements
BW_label_matrix = labelmatrix(BW_conn_comp);
%imshow(BW_label_matrix, [])
%unique(BW_label_matrix(:))

% _Obtneim l'objecte major_
% Fem tipu bwpropfilt(BW, "Area", 1, "largest"), però amb els labeled.
max_val_BW = 0;
for cada_comp = 1:BW_conn_comp.NumObjects
    
    % Si la suma dels pixels de cada component és major que el contador
    % especificat:
    BW_equal = BW_label_matrix == cada_comp;
    if sum(BW_equal(:)) > max_val_BW
        max_val_BW = sum(BW_label_matrix == cada_comp); % definim de nou la suma

        % Definim la imatge singular
        BW_non_conn = BW_label_matrix == cada_comp;               
    end
end

BW_non_conn = BW_non_conn > 0;
%imshow(BW_non_conn)


end