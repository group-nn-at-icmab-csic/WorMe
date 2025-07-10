function [BW_non_conn] = obtain_major_connected(BW_amb_conexions, num_conexio)

% Given a binary image, with different connected objects (eg: two
% pixels that touch, or are adjacent to each other), the image with the largest area is returned.
% This is used to remove from a binary image all those pixels that
% are adjacent to it, for example, that touch it but are not part of
% the image.
%
%
% Variables
% num_conexio : Property conn of bwconncomp; are the connected elements (see doc bwconncomp). example: 4.
%
% Processing time
% tic; [BW_non_conn_major] = obtain_major_connected(BW_edges_final_p, 4);toc
% Elapsed time is 0.017739 seconds.
%
% See also
% bwconncomp
% labelmatrix

BW_conn_comp = bwconncomp(BW_amb_conexions, num_conexio);

% Make a matrix with the different elements
BW_label_matrix = labelmatrix(BW_conn_comp);
%imshow(BW_label_matrix, [])
%unique(BW_label_matrix(:))

% _Obtain biggest object_
% Make type bwpropfilt(BW, "Area", 1, "largest"), but with the labeled.
max_val_BW = 0;
for cada_comp = 1:BW_conn_comp.NumObjects
    
    % If the sum of the pixels of each component is greater than the specified counter
    BW_equal = BW_label_matrix == cada_comp;
    if sum(BW_equal(:)) > max_val_BW
        max_val_BW = sum(BW_label_matrix == cada_comp); % define the sum again

        % We define the singular image
        BW_non_conn = BW_label_matrix == cada_comp;               
    end
end

BW_non_conn = BW_non_conn > 0;
%imshow(BW_non_conn)


end