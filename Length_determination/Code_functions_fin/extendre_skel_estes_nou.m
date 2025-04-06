function [BW_skel_final_estes] = extendre_skel_estes_nou(BW_inicial, BW_skel, opc_ext, ext_val)

% Given a binary image and its skeleton, the skeleton is extended to the largest two points of the object.
%
% It is based on creating a line that has the least variation among the
% set of angles formed between the line and each specific point.
% In other words, it finds the line that closely follows the last pixels of
% the skeleton line.
%
% Variables
%
% Input
% BW_initial: Initial binary image
%
% BW_skel: Initial skeletonized image
%
% ext_option: Determines the option for extending the skeletonized image
%           "fixed": Fixed; defines a fixed value as the number
%                   of pixels by which the matrix will be extended.
%           "prop": Proportional; defines a percentage value relative
%                   to the total length of the skeletonized image, by which the matrix will be extended.
%
%
% Output
% BW_final_extended_skel: Final skeletonized image after extension
%
% Internal Functions
% new_matrix: Creates a matrix based on a point in the image. This allows
% operating only in that region.
%
%
% Upgrade regarding extend_skel_extension:
% Option to specify the extension value of the skeletonization, beyond
% what is determined by the distance of the endpoints in bwdist.
% This means that the region (matrix) around the endpoint is expanded,
% including the skeletonized image within it. This allows determining
% the angle with the longest length of the skeletonized image and the
% largest perimeter. The parameters ext_option and ext_value are added.
%
%
% Development Time
% Elapsed time is 0.057187 seconds.
%
% See also
% matriu_nova
% extendre_skel_estes


% (CAT)
% Donada una imatge binaria i el seu esquelet, allarga aquest fins a la punta.
%
% Es basa amb la creació d'una línia que tindrà una menor variació entre el
% conjunt dels angles que es formaràn entre aquesta i el punt en concret.
% És a dir, en la línia que té més segueixi a els ultims pixels de
% la línia d'esqueletonització.

% ÇÇÇ fer que nomes es detecti un objecte. El mes gran si n'hi ha mes d'un.


%imshow(imoverlay(BW_inicial, BW_skel, "r"), 'InitialMagnification','fit')

% Si el valor és fixat:
if opc_ext == "fixed"
    % Definim la variable d'extensió de la matriu com a el valor definit, fixe.
    %disp("Valor extensió fixe")
    val_ext_mat = ext_val;
    
elseif opc_ext == "prop"
    % Definim la variable d'extensió de la matriu com a el valor de la proporció definida respecte el total de l'objecte esqueletonitzat.
    %disp("Valor extensió proporcional")
    val_ext_mat = round(sum(BW_skel(:)) * ext_val/100);
end
    %ext_val


% _Obtenció dels endpoints_

% x,y
[x_endpoint, y_endpoint] = find(bwmorph(BW_skel, 'endpoints'));
% index
inx_endpoints = find(bwmorph(BW_skel,'endpoints'));

% Valors de distancia en els endpoints
BW_single_dist = bwdist(~BW_inicial);
%imshow(BW_single_dist, [])
valors_endopints = BW_single_dist(inx_endpoints);

% % Grafiquem els endpoints
% imshow(imoverlay(BW_inicial, BW_skel, "r" ))
% hold on;
% plot(y_endpoint, x_endpoint, 'b.','markersize',14)
% hold off

% _Obtenció imatge perimetral_
[BW_perimeter] = perimet_BW(BW_inicial);

% La imatge binaria esqueltonitzada final:
BW_skel_final_estes = BW_skel;

% _Per cada endpoint_
for n_endpoint = 1:length(x_endpoint)
    
    % Si el endpoint està tocant al perímetre
    if BW_perimeter(x_endpoint(n_endpoint), y_endpoint(n_endpoint))
        % % Grafiquem
        %imshow(BW_perimeter); hold on
        %plot(y_endpoint(1), x_endpoint(1), 'b.','markersize',14); hold off
        %BW_perimeter(x_endpoint(1), y_endpoint(1))
        %imshow(BW_skel); hold on
        %plot(y_endpoint(1), x_endpoint(1), 'b.','markersize',14); hold off
        %BW_skel(x_endpoint(1), y_endpoint(1))
        %imshow(imoverlay(BW_perimeter, BW_skel, "r"))
        continue
    end
    
    % _Obtenció de les matrius_
    
    % Sumem en aquest el valor a extendre (val_ext_mat)
    % Matriu BW perimetral
    [matriu_nova_perimetral, ~, ~, matsort_perimetral, punt_centr_perimetral] = matriu_nova(BW_perimeter, round(double(valors_endopints(n_endpoint)))+1 +val_ext_mat, x_endpoint(n_endpoint), y_endpoint(n_endpoint));
    % figure; imshow(matriu_nova_perimetral, 'InitialMagnification','fit')
    
    %El mateix, amb la imatge esqueletonitzada
    [matriu_nova_skel, ~, ~, ~, ~] = matriu_nova(BW_skel, round(double(valors_endopints(n_endpoint)))+1 +val_ext_mat, x_endpoint(n_endpoint), y_endpoint(n_endpoint));
    % figure; imshow(matriu_nova_skel, 'InitialMagnification','fit')
    
    %imshow(imoverlay(matriu_nova_perimetral, matriu_nova_skel, "r"))
    % Possible filtre: bwconncomp(matriu_nova_perimetral|matriu_nova_perimetral, 4)
    
    % __Tractament amb matrius__
    
    % _Obtenció dels punts_
    [x_perim, y_perim] = find(matriu_nova_perimetral);
    % Fem el mateix amb els pixels de la imatge esqueletonitzada.
    [x_skel, y_skel] = find(matriu_nova_skel);
    
    
    % _Determinació angles_
    
    % Llista on guardem els angles (opcional)
    angles_llista_cell = {};
    
    % Guardem la desviació estándard, per a veure quina és la menor.
    std_lower = Inf;
    
    for n_pixel_perim = 1:length(y_perim)
        
        % On guardarem els angles:
        angle_pix_mean_proba = [];
        
%         %Ho grafiquem alhora
%         matriu_nova_graficar = matriu_nova_skel|matriu_nova_perimetral;
%         figure
%         imshow(matriu_nova_graficar, 'InitialMagnification','fit')
%         hold on
        
        % Mirem per a cada pixel de la esqueletonització:
        for n_pixel_skel = 1:length(x_skel)
            
            % Obtenim l'angle
            angle_pix = abs(atand((y_skel(n_pixel_skel) - y_perim(n_pixel_perim))/(x_skel(n_pixel_skel) - x_perim(n_pixel_perim))));
            
            % Afegim a la mitjana del angle:
            if isempty(angle_pix_mean_proba)
                angle_pix_mean_proba = angle_pix;
            else
                angle_pix_mean_proba(end+1) = angle_pix;
            end    
            
            % grafiquem
            %line([y_perim(n_pixel_perim), y_skel(n_pixel_skel)], [x_perim(n_pixel_perim), x_skel(n_pixel_skel)]);
            %text(y_skel(n_pixel_skel), x_skel(n_pixel_skel), string(round(angle_pix, 1)));
            
        end
        %hold off
        
        % Guardem en
        angles_llista_cell{end+1} = angle_pix_mean_proba; % ÇÇÇ potser no cal
        
        % %mostrem el sd i mean
        %mean(angle_pix_mean_proba)
        %std(angle_pix_mean_proba)
    
        % Si la desviació estándard és menor:
        if std(angle_pix_mean_proba) < std_lower
            std_lower = std(angle_pix_mean_proba);
            
            % % Guardem la posicio (per graficar a posteriori)
            %punt_minor = n_pixel_perim;
            
            % Guardem el punt on l'angle té una sd menor
            punt_final_menorangl = [x_perim(n_pixel_perim), y_perim(n_pixel_perim)];
            %disp("THE MINIMAL")
        end
    end
    
    
    % __Graficació de la regió__
        
%     % Ho grafiquem alhora
%     matriu_nova_graficar = matriu_nova_skel|matriu_nova_perimetral;
%     figure; imshow(matriu_nova_graficar, 'InitialMagnification','fit'); hold on
%     % Mirem per a cada pixel de la esqueletonització:
%     for n_pixel_skel = 1:length(x_skel)
%         % Obtenim l'angle
%         angle_pix = abs(atand((y_skel(n_pixel_skel) - y_perim(punt_minor))/(x_skel(n_pixel_skel) - x_perim(punt_minor))));        
%         % Afegim a la mitjana del angle:
%         if isempty(angle_pix_mean_proba); angle_pix_mean_proba = angle_pix;
%         else; angle_pix_mean_proba(end+1) = angle_pix; end            
%         % grafiquem
%         line([y_perim(punt_minor), y_skel(n_pixel_skel)], [x_perim(punt_minor), x_skel(n_pixel_skel)]);
%         text(y_skel(n_pixel_skel), x_skel(n_pixel_skel), string(round(angle_pix, 1)));
%     end; hold off
    
    
    
    % _Obtenció en imatge_
    % Fem imatge de zeros
    matriu_punts_fin = false(size(matriu_nova_perimetral));
    
    % Apliquem els punts:
    matriu_punts_fin(punt_final_menorangl(1), punt_final_menorangl(2)) = true;
    matriu_punts_fin(punt_centr_perimetral(1), punt_centr_perimetral(2)) = true;
    
%     figure; imshow(matriu_punts_fin, 'InitialMagnification','fit')
    
    % Ara, dels dos punts fem una linia
    matriu_punts_linia = bwconvhull(matriu_punts_fin);
%     figure; imshow(matriu_punts_linia, 'InitialMagnification','fit')
    
    % Si volguéssim, ho podem graficar a la principal
%     matriu_nova_graficar_fin = matriu_nova_graficar;
    
%     matriu_nova_graficar_fin = matriu_nova_graficar_fin|matriu_punts_linia;
%     figure; imshow(matriu_nova_graficar_fin, 'InitialMagnification','fit')
    
%     figure; imshow(imoverlay(matriu_nova_graficar_fin, matriu_punts_linia, "r"), 'InitialMagnification','fit')

    %ara ho hem de passar a la imatge principal,

    % Ho escalem a la imatge original:
    % Tenim els punts, els cuals guardarem com posicions, i no com imatge, per tal d'optimitzar la imatge. Lo complicat serà veure com passem de la matriu (imatge) petita, a la gran.
%     figure; imshow(matriu_punts_linia, 'InitialMagnification','fit')
    
    % Busquem els punts
    [y_linia, x_linia] = find(matriu_punts_linia);

    % Quan habiem obtingut la imatge, habiem guardat les coordenades de la mateixa en la seva obtenció:
%     matsort_perimetral
    
    % Això significava que si feiem un BW(x1:x2, y1:y2) amb aquestes regións, obteniem la imatge.
    % Suposem que són x1, x2, y1, y2:
    % Si suméssim a les línies:
%     BW_perimeter_proba = BW_perimeter;
%     figure; imshow(BW_perimeter_proba)
    
    % Definim els punts x i y
    x_linia_escalatBW = x_linia + matsort_perimetral(3)-1;
    y_linia_escalatBW = y_linia + matsort_perimetral(1)-1;
    
    % Grafiquem BW_skel amb la regió, obtenint BW_skel_final_estes.
    ind_linia_escalatBW = sub2ind(size(BW_skel_final_estes), y_linia_escalatBW, x_linia_escalatBW);    
    BW_skel_final_estes(ind_linia_escalatBW) = true;
    
%     figure; imshow(BW_skel_final_estes)
    

end
% figure; imshow(imoverlay(BW_skel|BW_perimeter, (BW_skel_final_estes - BW_skel)>0, "r"))    


% figure; imshow(imoverlay(BW_inicial, BW_skel_final_estes, "r"))


end