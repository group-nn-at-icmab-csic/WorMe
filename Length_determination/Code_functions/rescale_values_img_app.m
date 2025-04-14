function [pos_img2] = rescale_values_img_app(pos_fig, pos_img, pos_fig2)

% Dona la nova posició d'una imatge, donades les posicions que aquesta
% tenia en la figura, i la nova posició de la figura.
%
% pos_fig = app.UIFigure.Position;
% pos_img =  app.Image.Position;
% pos_fig2 = app.UIFigure.Position
%
%
% app.Image.Position = [ (x/ample_i) * ample_i2, ...
%                        (y/llarg_i) * llarg_i2, ...
%                        (ample/ample_i) * ample_i2, ...
%                        (llarg/llarg_i) * llarg_i2];
                   
% Posicio figura
x_i = pos_fig(1);
y_i = pos_fig(2);
ample_i = pos_fig(3);
llarg_i = pos_fig(4);

% Posicio imatge
x = pos_img(1);
y = pos_img(2);
ample = pos_img(3);
llarg = pos_img(4);

% app.UIFigure.WindowState = 'maximized';
% pause(1)

% Posicio figura nova
x_i2 = pos_fig2(1);
y_i2 = pos_fig2(2);
ample_i2 = pos_fig2(3);
llarg_i2 = pos_fig2(4);

% Canvi posicio relatiu
pos_img2 = [ (x/ample_i) * ample_i2, ...
            (y/llarg_i) * llarg_i2, ...
            (ample/ample_i) * ample_i2, ...
            (llarg/llarg_i) * llarg_i2];
        
        
end
        
        