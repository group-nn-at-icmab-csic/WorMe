function app_proc_button_to_left_img(app)

% In app_image_processing App, the button of to the left image (Button_12Pushed).
% Change the image to the previous one in the folder.
%
% See also
% app_image_processment


% START OF THE FUNCTION

    app.Image2.Visible = 'on';
    

    % __Cambiem contador imatge__
    % Contador imatge
    numero_dreta = str2num(app.contador_numimLabel.Text);
    numero_dreta = numero_dreta -1;
    
    % definim contador
    app.contador_numimLabel.Text = string(numero_dreta);

    % DEFINICIÓ DE LA IMATGE
    % Carpeta de les imatges
    theFiles = app.theFiles_arxiu;
    
    % Obtencio imatge
    baseFileName = theFiles(numero_dreta).name;
    fullFileName = fullfile(theFiles(numero_dreta).folder, baseFileName);
    
    % CAMBIEM RUTA IMATGE
    app.vapp_ruta_img_origin = fullFileName;

    % VISUALIZATION OF THE MODIFICATIONS
    app_proc_visual_modif(app)


    % Grafiquem la imatge original nova
    app.Image3.ImageSource = app.vapp_ruta_img_origin;            


    % _Aparició/amagat botóns_
    app.Image2.Visible = 'off';
    if numero_dreta > 1
        app.Button_12.Visible = 'on';
        app.Button_11.Visible = 'on';
    elseif numero_dreta == 1
        app.Button_12.Visible = 'off';
        app.Button_11.Visible = 'on';                
    end

% END OF THE FUNCTION


end