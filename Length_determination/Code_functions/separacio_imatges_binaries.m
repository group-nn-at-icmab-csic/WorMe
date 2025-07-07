function [llistat_imatges] = separacio_imatges_binaries(BW_final_conjunts)

% D'una imatge binaria, retorna una cell amb la imatge on apareix cada
% objecte.

% START FUNCTION

% -- input: BW_final_conjunts
% -- output: llistat_imatges


%A partir d'aqui tenim la imatge binaritzada. El que volem determinar,
%però, és les imatges amb una llargada d'esqueletonització. Per a fer-ho,
%necessitarem segmentar la imatge i analitzar cada imatge de manera
%singular.

% %Si esqueletonitzem:
% BW_skel = bwskel(BW_final_conjunts);
% imshow(BW_skel)
% 

% SEPARACIÓ IMATGES BINÀRIES. 
% Resultat: cell amb les imatges separades
[L_variable, num] = bwlabel(BW_final_conjunts);
% imshow(L_variable, [])


%unique(L) és igual a num, que és el nombre de distincións.

llistat_imatges = {};

%Separem cada una, les mostrem:
for k_for_cada = 1 : num
    thisBlob = ismember(L_variable, k_for_cada);
%     figure
%     imshow(thisBlob, []);
    llistat_imatges{length(llistat_imatges)+1} = thisBlob;
end

%Ara tenim 'llistat_imatges', que és una cell que té cada imatge.
% llistat_imatges
% length(llistat_imatges)


% El resultat de la funció és una cell amb varies imatges. A partir d'aquí,
% s'hauria de llegir i filtrar cada una d'aquestes imatges.

% END FUNCTION


end