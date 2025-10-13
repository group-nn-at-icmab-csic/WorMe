function app_interf_definicio_mean_width(app, S_textscan_table)

% Definition of the filter value for mean width

% FUNCTION START

% Define the filtered table for the selected images:
S_textscan_table_yesfilt = S_textscan_table(S_textscan_table.IsCeleg == "yes", :);

% __Mean width filter__            
% The filter value will be based on the final value which will be the
% factor applied to the mean of the total widths.

% Obtain the values of all the widths
width_total_values = appf_split_strindex(S_textscan_table_yesfilt.WidthValues);
% Calculate the mean of these values
width_total_mean = mean(width_total_values);


% Apply the percentage factor defined in the GUI
width_val_filtr = (app.SpinnerWidthMean.Value/100) * width_total_mean;

% Set in the textarea. The value of this will be used to apply the filter.
app.MinWidthRefTextArea.Value = string(width_val_filtr);


% FUNCTION END


end