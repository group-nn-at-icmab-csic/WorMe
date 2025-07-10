function  [indx_BWskel_obj_fin] = wide_indx_nonendpoints(indx_BWskel_obj, indx_endpoints_BWskel, size_BW_objecte_skel)

% Given a skeletonized image, the wide_indx_BB is done, but the endpoints of the image are not widened.
%
%
% Processing time: Elapsed time is 0.001236 seconds.
%
% See also
% wide_indx_BB

% START FUNCTION

[~, pos_ismemb] = ismember(indx_endpoints_BWskel, indx_BWskel_obj);

% Delete the positions
indx_BWskel_obj(pos_ismemb) = [];

[indx_BWskel_obj_eixamp] = wide_indx_BB(indx_BWskel_obj, 1, size_BW_objecte_skel);

% Add endpoints:
indx_BWskel_obj_fin = [indx_BWskel_obj_eixamp; indx_endpoints_BWskel];

% END FUNCTION


end