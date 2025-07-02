function [logical_value]= char2logical_josep(char_value)

% From character to logic (own function)

if char_value == "false" || char_value == "False"
    logical_value = false;
elseif char_value == "true" || char_value == "True"
    logical_value = true;
else
    msgbox("No false/true character on char2logical_josep", "Error", "error")
end

end
