function [result_numer] = retorna_zeros(valor_num)

% Donat un valor numèric, retorna aquest en forma de string omplert amb zeros. 
% La funció és numerar una imatge de manera adecuada.
%
% Exemple variable
% valor_num = 696;

nombre_zeros = 5 - numel(num2str(round(valor_num)));

if nombre_zeros == 0
    result_numer = string(valor_num);
elseif nombre_zeros == 1
    result_numer = strcat("0", string(valor_num) );
elseif nombre_zeros == 2
    result_numer = strcat("00", string(valor_num));
elseif nombre_zeros == 3
    result_numer = strcat("000", string(valor_num));
elseif nombre_zeros == 4
    result_numer = strcat("0000", string(valor_num));
elseif nombre_zeros == 5
    result_numer = strcat("00000", string(valor_num));
elseif nombre_zeros < 0
    msgbox('Invalid Value', 'Error','error');
end


end