function app_proc_button_region_imopen(app)

% In app_image_processing App, the button of .
%
%
% See also
% app_image_processment


% START OF THE FUNCTION

    % COPIA adaptada de imopen:
    
    % Button Open
    
    
    % "open_disc(valor)"
    % "close_disc(valor)"
    
    
    % Valor del imopen regio
    valor_modif = app.Spinner_4.Value;
    
    % Afegim al text la modificació
    text_modific = strcat("region_imopen(", string(valor_modif), ")");
    txt_seg(field_set, text_modific, ";") % seguiment config.


% END OF THE FUNCTION


end