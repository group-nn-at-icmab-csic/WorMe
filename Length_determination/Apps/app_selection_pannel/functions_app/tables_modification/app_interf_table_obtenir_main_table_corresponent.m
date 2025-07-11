function [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = app_interf_table_obtenir_main_table_corresponent(app)

% Applies the obtaining of the current modification, but moves on to the next
% image if there are no objects left in the current image (

% START OF THE FUNCTION

[main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = app_interf_table_obtenir_main_table_actual(app);

% If there are no more objects, move to the next image and re-define.
if isempty(no_modified_object)
    %disp("isempty")
    n_imatge = str2double(app.img_contLabel.Text);
    
    % ______Precedence______
    % NOTE: See/base on 'app_interf_precedencia_img'
    % disp("Precedencia img")


    if (n_imatge +1) <= str2double(app.img_tot_nLabel.Text)
        %disp("No final")
        % ___Updates___
        % _image counter_
        app.img_contLabel.Text = string(n_imatge+1);
        %_image name_
        [~ , nom_img_original] = app_interf_obtain_original(app, n_imatge+1);        % Obtaining image name
        app.img_original_nomLabel.Text = nom_img_original;         % Updating image name
        
        
        % Obtain modifications again:
        % Note: Later we will plot based on these annotations
        % and the state of the GUI (which we have re-defined at +1).
        [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = app_interf_table_obtenir_main_table_actual(app);
        
        % Update buttons (imcrop)
        app.imcrop_value = [];

    else
        % IMAGES FINISHED
        % app_interf_boto_estadist(app)
        
    end
end

% FINAL OF THE FUNCTION


end