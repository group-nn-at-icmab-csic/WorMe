function app_proc_desact_act_buttons(app, tipus_im_modif)

% Activation/Deactivation of buttons depending on the described image typology.

% START OF THE FUNCTION

    app.returnButton.Enable = 'on';

    if tipus_im_modif == "rgb"
        % rgb
        app.Im2greyButton.Enable = 'on';
        % gray
        app.imadjustButton.Enable = 'off';
        app.BinarizeButton.Enable = 'off';
        % binary
        app.AreaOpenButton.Enable = 'off';
        app.imclearborderButton.Enable = 'off';
        app.imfillButton.Enable = 'off';
        app.OpenButton.Enable = 'off';
        app.CloseButton.Enable = 'off';
        app.Spinner.Enable = 'off';
        app.Spinner_2.Enable = 'off';
        app.Spinner_3.Enable = 'off';
        app.imadjust_selectButton.Enable = 'on';
        app.edgeapproxcannyButton.Enable = 'off';
        app.DropDown.Enable = 'off';
        app.EsqueletonitzarButton.Enable = 'off';
        app.AnalyseButton.Enable = 'off'; 
        app.RequirmentAnalysisText.Visible = 'on';
        app.flipButton.Enable = 'off';
        app.edgeapproxcannyButton.Enable = 'on';
        app.BinarizebyvalueButton.Enable = 'off';
        app.BinarizeSlider.Enable = 'off';
        
    elseif tipus_im_modif == "gray"
        % rgb
        app.Im2greyButton.Enable = 'off';
        % gray
        app.imadjustButton.Enable = 'on';
        app.BinarizeButton.Enable = 'on';
        % binary
        app.AreaOpenButton.Enable = 'off';
        app.imclearborderButton.Enable = 'off';
        app.imfillButton.Enable = 'off';
        app.OpenButton.Enable = 'off';
        app.CloseButton.Enable = 'off';
        app.Spinner.Enable = 'off';
        app.Spinner_2.Enable = 'off';
        app.Spinner_3.Enable = 'off';
        app.imadjust_selectButton.Enable = 'on';
        app.edgeapproxcannyButton.Enable = 'off';        
        app.DropDown.Enable = 'on';
        app.EsqueletonitzarButton.Enable = 'off';
        app.AnalyseButton.Enable = 'off';
        app.RequirmentAnalysisText.Visible = 'on';
        app.flipButton.Enable = 'off';
        app.edgeapproxcannyButton.Enable = 'on';       
        app.BinarizebyvalueButton.Enable = 'on';        
        app.BinarizeSlider.Enable = 'on';
        
    elseif tipus_im_modif == "binary"
        % rgb
        app.Im2greyButton.Enable = 'off';
        % gray
        app.imadjustButton.Enable = 'off';
        app.BinarizeButton.Enable = 'off';
        % binary
        app.AreaOpenButton.Enable = 'on';
        app.imclearborderButton.Enable = 'on';
        app.imfillButton.Enable = 'on';
        app.OpenButton.Enable = 'on';
        app.CloseButton.Enable = 'on';
        app.Spinner.Enable = 'on';
        app.Spinner_2.Enable = 'on';
        app.Spinner_3.Enable = 'on';
        app.imadjust_selectButton.Enable = 'off';
        app.edgeapproxcannyButton.Enable = 'on';        
        app.DropDown.Enable = 'off';
        app.EsqueletonitzarButton.Enable = 'on';
        app.AnalyseButton.Enable = 'on';    
        app.RequirmentAnalysisText.Visible = 'off';
        app.flipButton.Enable = 'on';
        app.edgeapproxcannyButton.Enable = 'off';
        app.BinarizebyvalueButton.Enable = 'off';        
        app.BinarizeSlider.Enable = 'off';
        
    else
        error("error en deteccio tipus imatge")
    end
   
% END OF THE FUNCTION

end