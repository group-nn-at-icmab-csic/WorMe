function msgbox_sel_images(userSavedDocuments)

% Descriu un msgbox fins a 7 vegades de l'execució del programa.

% START FUNCTION

    file_contadors = strcat(userSavedDocuments, "\Results_out\Internal_code_files\cont_started.mat");
    if ~isfile(file_contadors)
        cont_started = 0;
        save(file_contadors, "cont_started")
    else
        cont_started = getfield(load(file_contadors), "cont_started");
        cont_started = cont_started + 1;
        save(file_contadors, "cont_started")
    end
        
    if cont_started < 7
        ms_g = imread("icon_48.png");
        waitfor(msgbox("Please, select the images to analyse.", "Select images", 'custom', ms_g));
    end

% END FUNCTION

end
