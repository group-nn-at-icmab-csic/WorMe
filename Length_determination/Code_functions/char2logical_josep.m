function [logical_value]= char2logical_josep(char_value)

% Funció que passa de caracter a logic.

if char_value == "false" || char_value == "False"
    logical_value = false;
elseif char_value == "true" || char_value == "True"
    logical_value = true;
else
    msgbox("No false/true character on char2logical_josep", "Error", "error")
end

end
