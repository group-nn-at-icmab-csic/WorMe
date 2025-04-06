function appini_mostrar_imatges_props(app, S_textscan_table)

% Descriu en la GUI les dades de la imatge, donada la taula amb les rutes
% de les imatges.
%
%
% Variables
%   input
%       S_textscan_table : taula amb les rutes de les imatges
% 
%
%
% See also
%


% INICI FUNCIÓ


% _Selecció/Desselecció botóns_
app.NofimagesLabel.Visible = 'on';
app.n_value_imagesLabel.Visible = 'on';
app.current_folderLabel.Visible = 'on';
app.FolderLabel.Visible = 'on';
app.UIAxes.Visible = 'on';




% _Contadors_
app.n_value_imagesLabel.Text = string(height(S_textscan_table));

app.n_img_acutLabel.Visible = 'on';
app.n_img_acutLabel.Text = "1";

app.img_nameLabel.Visible = 'on';
nom_img_t = split(S_textscan_table.Image_file(1), "\");
nom_img_curr = nom_img_t(end);
app.img_nameLabel.Text = nom_img_curr;

            
% Mostrem imatge en la GUI
imageArray_escala = imread(S_textscan_table.Image_file(1)); % Imatge inicial

% Mostrat en axes
imshow(imageArray_escala, 'Parent', app.UIAxes); 

% Guardem la imatge
app.img_main = imageArray_escala;

% Obtenim propietats de la imatge
app.ImageresolutionLabel.Visible = 'on';
app.valure_resolutionLabel.Visible = 'on';
app.ImagefiletypeLabel.Visible = 'on';
app.image_type_fileLabel.Visible = 'on';

img_info = imfinfo(S_textscan_table.Image_file(1));

% Posem valors de format i resolució de la imatge:
app.image_type_fileLabel.Text = img_info.Format;
app.valure_resolutionLabel.Text = strcat(string(img_info.Height), "x", string(img_info.Width));


% Mirem tipus imatges al llarg de la carpeta:
imtypes = []; % Tipus d'imatges en la carpeta
restypes = []; % Tipus de resolucions en la carpeta
for n_elem = 1:height(S_textscan_table)
    fullFileName_temp = S_textscan_table.Image_file(n_elem); % fullfile(theFiles(n_elem).folder, theFiles(n_elem).name);
    img_info_temp = imfinfo(fullFileName_temp);
    img_info_temp_format = string(img_info_temp.Format);
    if isempty(imtypes)
        imtypes = [img_info_temp_format];
    elseif ~ismember(img_info_temp_format, imtypes)
        imtypes(end+1) = img_info_temp_format;
    end
    
    % Resolucio
    str_resolucio = strcat(string(img_info_temp.Height), "x", string(img_info_temp.Width));
    if isempty(restypes)
        restypes = [str_resolucio];
    elseif ~ismember(str_resolucio, restypes)
        restypes(end+1) = str_resolucio;
    end
end

% Afegim a els textos de la app:
app.file_typesLabel.Text = strjoin(imtypes, ", ");
app.resol_typesLabel.Text = strjoin(restypes, ", ");

% çç possible funció: que es mostri el contingut de les
% propietats de la imatge en una GUI.

% FINAL FUNCIÓ


end