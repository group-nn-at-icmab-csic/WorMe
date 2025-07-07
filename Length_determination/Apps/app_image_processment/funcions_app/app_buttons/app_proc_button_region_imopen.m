function app_proc_button_region_imopen(app)

% In app_image_processing App, the button of .
%
%
% See also
% app_image_processment


% START OF THE FUNCTION

    % COPIA adaptaded from imopen:
    
    % Button Open
   
    % Value of the imopen region
    valor_modif = app.Spinner_4.Value;
    
    % Add the modification to the text
    text_modific = strcat("region_imopen(", string(valor_modif), ")");
    txt_seg(field_set, text_modific, ";") % config. tracking


% END OF THE FUNCTION


end