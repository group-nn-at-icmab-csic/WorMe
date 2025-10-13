function app_proc_button_to_right_img(app)

% In app_image_processing App, the button of to the right image (Button_11Pushed).
% Change the image to the next one in the folder.
%
% See also
% app_image_processment


% START OF THE FUNCTION

    app.Image2.Visible = 'on';
    
    % __Change image counter__
    % Image counter
    numero_dreta = str2num(app.contador_numimLabel.Text);
    numero_dreta = numero_dreta + 1;
    
    % define counter
    app.contador_numimLabel.Text = string(numero_dreta);


    % IMAGE DEFINITION
    theFiles = app.theFiles_arxiu;
    
    % Get image
    baseFileName = theFiles(numero_dreta).name;
    fullFileName = fullfile(theFiles(numero_dreta).folder, baseFileName);
    
    % CHANGE IMAGE PATH
     app.vapp_ruta_img_origin = fullFileName;

   
    % VISUALIZATION OF THE MODIFICATIONS
    app_proc_visual_modif(app)


    % Plot the new original image
    app.Image3.ImageSource = app.vapp_ruta_img_origin;


    % _Show/hide buttons_

    % Length of images
    llargada_ims = length(theFiles); % Total image count
    
    if numero_dreta > 1
        app.Button_12.Visible = 'on';
        app.Button_11.Visible = 'on';
    end
    if numero_dreta == llargada_ims
        app.Button_12.Visible = 'on';
        app.Button_11.Visible = 'off';                
    end



    app.Image2.Visible = 'off';

% END OF THE FUNCTION


end