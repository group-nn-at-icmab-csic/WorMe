function [valor_max] = seleccio_branca_llargada_singular(BW_imatge_entrada)

% Donada una imatge binaria, es retorna el valor de la llargada més gran.
 

% Nota: BL = branques llargada


% INICI FUNCIÓ

% SELECCIÓ BRANCA MAJOR LLARGADA
% %Seleccionar la branca més llarga de la imatge esqueletonitzada
% %Una manera de seleccionar podria ser veure si hi ha moltes branques.

% Funció bwmorph() troba els punts de les branques, indexats.
% Funció find() troba els punts finals.
% Funció bwdistgeodesic() crea el mapa de valors de la imatge en augment a
% esqueletonitzada, els cuals augmenten a partir dels branchpoints fins a
% arribar al final de la branca (ex: 1 2 3 4 4 5 6 7...)
%
% Per a obtenir els valors, es determina el punt final de la branca (i i j), en la
% imatge obtinguda de la funció bwdistgeodesic (D), resultant el valor
% máxim sobre el que s'allunya la branca. 

% 
% %Per cada imatge binària que s'ha segmentat de la inicial:
% % It = BW_skel_cell;
% It = bwskel(BW_imatge_entrada);
% B_variable_B =  bwmorph(It,'branchpoints');    %dona els branchpoints en la imatge. Per a trobar-los fer: find()
% %sum(B(:)) % = 2
% [var_i,var_j] = find(bwmorph(It,'endpoints'));  %punts finals de les branques
% index_endpoints = find(bwmorph(It,'endpoints')); %<- modificat Josep
% variable_D = bwdistgeodesic(It, index_endpoints(1),'quasi');  %<- Modificat Josep
% %Hem determinat com un punt d'inici del gradient com el punt indexat d'una
% %de les puntes de l'imatge esqueletonitzada. Si es donaven sols els punts de les puntes (index_endpoints, completament), 
% % donava zero, donat que el gradient de valors es repartia des del centre de la imatge
% %esqueletonitzada. D'aquesta manera es pot obtenir un valor de distància
% %entre el punt final.
% %D = bwdistgeodesic(It, find(B),'quasi');     %find(B) dona els índex dels punts. Es a dir, diu en quina ubicació es troben, no per coordenades sinó per indexació.
% 
% %     figure
% %     imshow(variable_D, []);  %<- modificat Josep. %veure la imatge squeleton modificada en gradient
% 
% 
% % VISUALITZACIÓ CONTRAST IMATGE ESQUELETON SEGMENTADA
% % Retallem la imatge per a visualització
% s=regionprops(BW_imatge_entrada,'centroid'); %<--- rellevant. S'agafa el centroide.
% BB=regionprops(BW_imatge_entrada,'BoundingBox');  %<--- rellevant
% BB;
% centroids = cat(1, s.Centroid);  %<- agafa els centroides de totes les figures?
% 
% % figure
% % hold on
% % plot(centroids(:,1),centroids(:,2), 'b*','MarkerSize',3)
% % hold off



%PROBLEMA: S'AGAFA UN PUNT ALEATORI, NO EL INICIAL NI EL FINAL ETC. ES
%PODRIA FER FOR IN RANGE PER A OBTENIR EL PUNT QUE DONGUÉS RESULTATS
%MAJORS, ES A DIR, ANAR PROBANT TOTS ELS PUNTS DE LA IMATGE I AGAFAR EL QUE
%DONGUI UN RESULTAT MÉS GRAN.



%EL QUE ES FA ÉS, COM AVANÇ, PERÒ ES PASSA PER A CADA PUNT DE LES PUNTES DE
%L'IMATGE ESQUELETONITZADA, I S'AGAFA ELS VALORS (TOTS) DE LA LLARGADA
%D'AQUESTS PUNTS RESPECTE CADA PUNTA DIFERENT, PER TAL D'OBTENIR EL MAJOR,
%EL MÉS GRAN.

% It = BW_skel_cell;
It = bwskel(BW_imatge_entrada);
B_variable_B =  bwmorph(It,'branchpoints');    %dona els branchpoints en la imatge. Per a trobar-los fer: find()
%sum(B(:)) % = 2
[var_i,var_j] = find(bwmorph(It,'endpoints'));  %punts finals de les branques
index_endpoints = find(bwmorph(It,'endpoints')); %<- modificat Josep

cell_vals_maxs = {};

for end_point_n = 1:length(index_endpoints)
    %disp("Index endpoint")
    index_endpoints(end_point_n);

    variable_D = bwdistgeodesic(It, index_endpoints(end_point_n),'quasi');  %<- Modificat Josep
    %D = bwdistgeodesic(It, find(B),'quasi');     %find(B) dona els índex dels punts. Es a dir, diu en quina ubicació es troben, no per coordenades sinó per indexació.

%         figure
%         hold on
%         imshow(D);

    for n = 1:numel(var_i)
%         text( ...       %text(x, y, text)
%             var_j(n), var_i(n), ... %
%             [num2str( variable_D(var_i(n), var_j(n)))], ...  % D(i(n), j(n)) = D(78, 1540) = 72 <- valor llargada branca. 
%             'color','g');

        % S'obtenen els valors de llargada de les diferents branques:
        cell_vals_maxs{length(cell_vals_maxs)+1} = variable_D(var_i(n), var_j(n));
    end
%         hold off


end

valor_max = 0;
for valor_cada = 1:length(cell_vals_maxs)
    %cell_vals_maxs{valor_cada};
    if valor_max < cell_vals_maxs{valor_cada}
        valor_max = cell_vals_maxs{valor_cada};
    end
end

%valor_max;




% imatge_sortida_branca%ççç

% FINAL FUNCIÓ



end