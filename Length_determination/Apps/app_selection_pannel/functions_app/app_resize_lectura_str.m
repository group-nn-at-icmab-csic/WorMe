function [but_values] = app_resize_lectura_str(button_text)

% Read the text like "548;339;100;74$548;339;100;74" and returns it as an array

% START OF THE FUNCTION

strsplit_but = split(button_text, "$");

but_values = [];
for n_but = 1:length(strsplit_but)
    but_pos = double(split(string(strsplit_but{n_but}), ";"))';
    but_values = [but_values; but_pos];
end
% but_values

% FINAL OF THE FUNCTION

end