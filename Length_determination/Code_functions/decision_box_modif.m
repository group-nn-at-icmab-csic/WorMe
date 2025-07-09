function [answer_msgebox] = decision_box_modif(string_text, string_text_up, answ1, answ2)

% Com quadre_decisio, però es defineixen les diferents variables.
% 
% % Variables exemple MATLAB Live
% string_text = "Vols fer això?";
% string_text_up = "Upa";
% answ1 = "pues nose";
% answ2 = "pues ok";

% See also:
% quadre_decisio
        
    % START OF THE FUNCTION

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

    % FINAL OF THE FUNCTION

end