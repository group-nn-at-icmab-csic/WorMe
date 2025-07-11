function app_interf_actualitzacio_graficacio(app, enrrere_porta)

% Generates the data update (determination of the current object), and
% the plotting of this data.

% START FUNCTION

% __Data advancement typology__ %
% If the data is advanced by modifications, a reading of the objects
% and an automatic positioning versus the images is performed.
% If there is no reading of the objects, as may happen with the right or
% left buttons, the precedence should not be automatic.

% If it is not an option for statistics?

% If the reading is normal (true)
if enrrere_porta
    % _Obtaining object data
    [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = app_interf_table_obtenir_main_table_corresponent(app);

    % If there is no normal reading, but instead a step back is performed.
else
    [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = app_interf_table_obtenir_main_table_actual(app);
end

% main_table_actual_last %ççç
% main_table_actual_last_modiftable
% no_modified_object


[n_yes, n_no] = app_interf_table_contar_pos(app);
% Elapsed time approx: Elapsed time is 0.057395 seconds. (in ~100 samples)
app.n_yesLabel.Text = string(n_yes);  % Display values on the buttons
app.n_yesLabel2.Text = string(n_yes);
app.n_noLabel.Text = string(n_no);
app.n_noLabel2.Text = string(n_no);

% If after executing the function, the variables indx_object_operate and
% no_modified_object are empty, it means there are no objects, or all have been deselected by the filters.

% If there are no objects
if isempty(indx_object_operate)
    % disp("No objects")
    
    
    % If it is the last image, the Done button is displayed:
    if isequal(str2num(app.img_contLabel.Text), str2num(app.img_tot_nLabel.Text))
        app.DoneButton.BackgroundColor = [0.39,0.83,0.07]; % Yellow color
    else
        app.DoneButton.BackgroundColor = [0.90,0.90,0.90];
    end

        if isempty(main_table_actual_last_modiftable)
            % Image without objects
            app_interf_table_actu_imatge_no_objectes(app)    

            % Image without objects, without selection: thick cross buttons not
            % operable. 
            app.ReturnButton.Visible = 'off';
        else
            % Image with objects, but without their selection.

            % Now we can plot the last modification
            appf_interf_table_graficacio(app, main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object)        

            % Object buttons selection?
            app_interf_table_actu_botons_objectes(app, false)

            app.ReturnButton.Visible = 'on';
        end
%     end

    
else
    % If there are objects:
    
    app_interf_table_actu_botons_objectes(app, true)
    app.ReturnButton.Visible = 'on'; % Return is outside because it depends on whether there are objects or not.
            
    % ___Re-describe morphological data of the current object___
    % We define the skel values of the current object (we had not done it
    % before to avoid doing it for every object) and add it to the
    % current modifications table.
    
    if isequal(no_modified_object(1,:).Length, "No_data_yet")
        [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = appf_interf_table_incorporar_BWskelmorph(app, main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object);
    end
    
    % Now we can plot the last modification
    appf_interf_table_graficacio(app, main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object)
    
    app.DoneButton.BackgroundColor = [0.90, 0.90, 0.90];

end


if ~app.finalitzat_a_estadistica % If it has not moved to statistics.
    app_interf_table_act_dretaesquerra(app)
    app_interf_taula_actu_return(app)
end

% % plotting
% [main_table_actual_last, main_table_actual_last_modiftable, indx_object_operate, no_modified_object] = app_interf_table_obtenir_main_table_actual(app)


% END FUNCTION


end