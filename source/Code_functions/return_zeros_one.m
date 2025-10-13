function [result_numer] = return_zeros_one(valor_num)

% Given a numeric value, return it as a string filled with
% zeros, so that the value is two digits.
% The function is to number an image appropriately.
%
% Example variable
% valor_num = 6;

nombre_zeros = 2 - numel(num2str(round(valor_num)));

if nombre_zeros == 0
    result_numer = string(valor_num);
elseif nombre_zeros == 1
    result_numer = strcat("0", string(valor_num) );
elseif nombre_zeros < 0
    msgbox('Invalid Value', 'Error','error');
end


end