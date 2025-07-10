function [pos_img2] = rescale_values_img_app(pos_fig, pos_img, pos_fig2)

% Returns the new position of an image, given the positions that it
% had in the figure, and the new position of the figure.
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
                   
% Figure position
x_i = pos_fig(1);
y_i = pos_fig(2);
ample_i = pos_fig(3);
llarg_i = pos_fig(4);

% Image position
x = pos_img(1);
y = pos_img(2);
ample = pos_img(3);
llarg = pos_img(4);

% app.UIFigure.WindowState = 'maximized';
% pause(1)

% New figure position
x_i2 = pos_fig2(1);
y_i2 = pos_fig2(2);
ample_i2 = pos_fig2(3);
llarg_i2 = pos_fig2(4);

% Change relative position
pos_img2 = [ (x/ample_i) * ample_i2, ...
            (y/llarg_i) * llarg_i2, ...
            (ample/ample_i) * ample_i2, ...
            (llarg/llarg_i) * llarg_i2];
        
        
end
        
        