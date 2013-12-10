function proll = soft_proll2proll(soft_proll, thresh, snl)
% function proll = soft_proll2proll(soft_proll, thresh, snl)
%
% SOFT_PROLL2PROLL converts soft-decision piano-roll matrix to binary 
% piano-roll matrix by thresholidng and postprocessing 'soft_proll' matrix.
%
% INPUTS
%   soft_proll              soft-decision piano-roll matrix
%   thresh                  threshold
%   snl                     short note length (post-processing)
%
% OUTPUTS
%   proll                   piano-roll matrix
%
% Date: 2.4.2013
% Author: Jan Bednarik
%

% thresholding
proll = soft_proll > thresh/prod(size(soft_proll));

% post-processing
proll = rem_short(proll, snl);

end
