function app_interf_boto_lupa(app)

% Magnifying glass button

% START OF FUNCTION


            main_image = app.Image.ImageSource;
            

            % Crop the image when zooming
            [~, xy_points_to_crop] = imcrop(main_image);


            % If a selection has been made
            if ~isempty(xy_points_to_crop)
                close
                xy_points_to_crop = floor(xy_points_to_crop);
                
                [first_cropped_image] = cut_imgs_points(main_image, xy_points_to_crop);
                %imshow(first_cropped_image)
                
                app.Image.ImageSource = first_cropped_image;
                                
                
                % _Show the image in a UIAxes_
                % ÇÇÇ GREATLY INCREASES QUALITY, IT'S THE WAY TO GO.
                % imshow("PNG_BW.png", 'Parent', app.UIAxes); 
                
                % Make the return image button visible:
                %app.LupaButton_return.Visible = 'on';

                % Save the variable
                app.imcrop_value = xy_points_to_crop;
                
            end            
            
            
            app.LupaReturnButton.Visible = 'on';



            % Refresh figure to enable shortkey
            figure(app.UIFigure)                


% END OF FUNCTION


end