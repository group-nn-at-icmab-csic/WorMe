function [answer_msgebox] = quadre_decisio(string_text)

% Obre quadre de diàleg per a marcar si es vol fer o no la operació
% 
% % Variables exemple
% string_text = "Vols fer això?";

answer_del = questdlg(string_text, ...
	string_text, ...
	'Yes','No', 'No');
% Handle response
switch answer_del
    case 'Yes'
        answer_msgebox = true;
    case 'No'
        answer_msgebox = false;
end

end