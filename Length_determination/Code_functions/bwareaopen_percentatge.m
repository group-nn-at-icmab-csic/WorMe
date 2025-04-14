function [imatge_sortida_bwareaopen, valor_p_bwareaopen] = bwareaopen_percentatge(imatge_filtrar_bwarea, valor_percentual)

% Obtenir el valor numèric de percentual de la superfície d'una imatge, amb l'intenció d'aplicar-ho a la funció bwareaopen().

% INICI FUNCIÓ 

% Determinem pixels petits
% Com que la funcií bwareaopen() es basa amb el máxim nombre de pixels en
% els objectes, entenem que el nombre de pixels pot ser proporcional a la
% superfície de la imatge.
% Es a dir, si determinem 500 pixels en la funció bwareaopen(), significa
% que s'eliminen aquells objectes els quals la seva suma sigui de 500.
% Això significa que, si per exemple definim un valor de 2300, 
% s'eliminaria un cuadrat que fés ~47 x 47, donat que sqrt(2800) és 47.
% Si aquest valor el comparem amb el de la imatge inicial, podem determinar
% un percentatge 

% Obtenim la superfície
[imatge_filtrar_bwarea_rows, imatge_filtrar_bwarea_cols, ~ ] = size(imatge_filtrar_bwarea);
imatge_filtrar_bwarea_superficie = imatge_filtrar_bwarea_rows .* imatge_filtrar_bwarea_cols;

% El quadrat de la superfície
sqrt_imatge_filtrar_bwarea_superficie = sqrt(imatge_filtrar_bwarea_superficie);

valor_p_bwareaopen = round(((valor_percentual/100) .* sqrt_imatge_filtrar_bwarea_superficie)^2);
% Nota: si el valor_percentual fos del 100, es a dir, 100%, el
% valor_p_bwareaopen seria el mateix que el de la superfície de la imatge.

imatge_sortida_bwareaopen = bwareaopen(imatge_filtrar_bwarea, valor_p_bwareaopen);
%imshow(imatge_sortida_bwareaopen)

% % Explicació teòrica fórmules matemàtiques
% 
% % Suposem bwareaopen(BW, 800)
% disp(sqrt(800))
% disp(sqrt_BW_bwa_superficie)
% (sqrt(800)/sqrt_BW_bwa_superficie).*100
% 
% 
% 
% % Suposem bwareaopen(BW, 2300)
% sqrt(2300)
% valor_percentual = (sqrt(2300)/sqrt_BW_bwa_superficie) .*100
% % Aquest valor es percentual entre la superficie que volem definir (2300) i
% % la de la imatge.
% % Si comparem directament les superfícies, hem d'aplicar l'arrel cuadrada 
% % a aquestes, donat que ?l'escala no es la mateixa:
% sqrt(2300 / BW_bwa_superficie) .* 100
% 
% % Del revés, definit la superfície total, que és el valor que interessa a
% % la variable bwareaopen()
% ((valor_percentual/100) .* sqrt_BW_bwa_superficie)^2
% 
% % Si obtinguessim entre una imatge i la mitat d'aquesta:
% ((sqrt_BW_bwa_superficie/2)/sqrt_BW_bwa_superficie) .*100
 

% FINAL FUNCIÓ
