function [answer_msgebox] = quadre_decisio_modif(string_text, string_text_up, answ1, answ2)

% Com quadre_decisio, però es defineixen les diferents variables.
% 
% % Variables exemple MATLAB Live
% string_text = "Vols fer això?";
% string_text_up = "Upa";
% answ1 = "pues nose";
% answ2 = "pues ok";

% See also:
% quadre_decisio


answer_del = questdlg(string_text, ...
    string_text_up, ...
    answ1, answ2, answ2);
% Handle response
switch answer_del
    case answ1
        answer_msgebox = true;
    case answ2
        answer_msgebox = false;
end

end