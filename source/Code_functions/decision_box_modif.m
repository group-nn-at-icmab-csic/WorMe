function [answer_msgebox] = decision_box_modif(string_text, string_text_up, answ1, answ2)

% Decision box with defined variables


% See also:
        
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

    % END FUNCTION

end