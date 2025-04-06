function [result_numer] = retorna_zeros_un(valor_num)

% Donat un valor numèric, retorna aquest en forma de string omplert amb
% zeros, de manera que el valor sigui de dos dígits.
% La funció és numerar una imatge de manera adecuada.
%
% Exemple variable
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