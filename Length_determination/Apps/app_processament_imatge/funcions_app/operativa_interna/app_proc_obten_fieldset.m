function [field_set] = app_proc_obten_fieldset(app)

% S'obté el field_set: ruta del arxiu txt de la modificació.

% INICI FUNCIO


% Agafem el text seleccionat del ListBox, segons el tipus de modificació seleccionat (temporal o guardat)
if ~isempty(app.ModificacionstemporalsListBox.Value)
    value_listbox = app.ModificacionstemporalsListBox.Value;
    field_set = strcat("Results_out\Internal_code_files\Image_processing_settings\temporals\", string(value_listbox));
% Si es pre-selecciona en guardats
elseif ~isempty(app.ModificacionsguardadesListBox.Value)
    value_listbox = app.ModificacionsguardadesListBox.Value;
    % Llegir arxiu i mostrar en Label Modificacions
    field_set = strcat("Results_out\Internal_code_files\Image_processing_settings\", string(value_listbox));
end

% FINAL FUNCIO


end