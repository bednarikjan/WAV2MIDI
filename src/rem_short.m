function prm = rem_short(proll, len)
% function prm = rem_short(proll, len)
%
% INPUTS
%   proll       piano-roll matrix
%   len         max lenght of notes to be removed
%
% OUTPUTS
%   prm         post-processed piano-roll matrix
% 
% Post-processing of piano-roll matrix. Removes all notes that are shorter
% then threshold 'len'.
% 
% Date: 2.4.2013
% Author: Jan Bednarik
%

% pad proll with one column of zeros from both sides
proll = [zeros(size(proll,1),1) proll zeros(size(proll,1),1)];

while len > 0
    note = [0 ones(1,len) 0];
    
    for ii = 1:size(proll,1)
        idx = strfind(proll(ii,:),note);
        
        for jj = 1:length(idx)
            proll(ii,idx(jj):(idx(jj)+len+1)) = zeros;
        end
    end
    
    len = len-1;
end

% piano-roll matrix
prm = proll(:,2:(end-1));

end
