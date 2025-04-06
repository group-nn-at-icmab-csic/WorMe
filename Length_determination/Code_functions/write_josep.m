function write_josep(variable_imatge_guardar, directori_write, mode_write_j, string1, string2, string3, string4, string5)

% Donada una imatge, un directori, i un o varis text, guarda la imatge amb el nom d'arxiu expecificat. 
% D'aquesta manera no cal haver de fer molts passos sino
% que es fa amb una sola linia de codi.

%   directori_write : directori, carpeta, a on es fa el write. Si
%                       s'especifica com a zero (0), en comptes de fer write el que es fa es
%                       retornar el nom de l'arxiu; això serveix per a poder veure cóm queda el
%                       nom de l'arxiu, i si és el nom que volem.
%                       Si s'especifica "", es guarda a la carpeta actual.
%
%   mode_write_j : si s'escriu diferents distintius cap endavant (1) o enrere (0)
%
%   string1 : nom de l'arxiu, si no s'especifica aquest serà com ".png"
% 

% INICI FUNCIÓ 

% Variables internes
% string_final : tipus d'arxiu (per defecte .png)
% 
% string_file

% Por si las moscas, pasem tot a strings:
string1 = string(string1);
if ~exist('string2','var') ; string2 = ""; end; string2 = string(string2);
if ~exist('string3','var') ; string3 = ""; end; string3 = string(string3);
if ~exist('string4','var') ; string4 = ""; end; string4 = string(string4);
if ~exist('string5','var') ; string5 = ""; end; string5 = string(string5);


% Si el primer element introduït conté un punt, es a dir, es defineix un
% arxiu de text:
if contains(string1, ".")
    splited_string1 = split(string1, ".");
    string_file = splited_string1{1};
    string_final = strcat(".", splited_string1{2});
    string1 = "";
else
    string_file = "";
    string_final = ".png";
end

% Descripció del nom complert de l'arxiu
if mode_write_j
    nom_arxiu_write = strcat(string_file, string1, string2, string3, string4, string5, string_final);
else
    nom_arxiu_write = strcat(string1, string2, string3, string4, string5, string_file, string_final);
end


% Descripció ubicació i nom complert arxiu
directori_write = string(directori_write);

% Cambiar per si s'ha deixat la barra
% Si no es sols 'display'
if directori_write ~= "0" && directori_write ~= ""
    splited_nom_arxiu_write = split(directori_write,"");
    es_barra = splited_nom_arxiu_write(end-1); %Nota: tots acaven amb "";
    if es_barra ~= "\"
        directori_write = directori_write + "\";
    end
end

% Write nom arxiu o display nom arxiu
if directori_write == "0"
    disp(nom_arxiu_write);
else
    nom_arxiu_write_final = directori_write + nom_arxiu_write;
    imwrite(variable_imatge_guardar, nom_arxiu_write_final);
end


% FINAL FUNCIÓ

end