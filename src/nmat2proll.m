function proll = nmat2proll(nmat, dt)
% function proll = nmat2proll(nmat, dt)
% 
% NMAT2PROLL converts note matrix 'nmat' (MIDI matrix) to binary piano-roll
% matrix 'proll' given time resolution 'dt'.
%
% Inputs
%   nmat    note matrix
%   dt      length of time frame in seconds
%
% Outputs
%   proll   binary piano-roll matrix
%
% Date: 2.4.2013
% Author: Jan Bednarik
%

% import common constants
constants;

lenSecs = max(sum(nmat(:,[onsetSec durSec]),2));    % signal length in secs

% prealocating space for ouptut piano-roll matrix
proll = zeros(pKeys, ceil(lenSecs / dt));

for ii = 1:size(nmat, 1)
    fromIdx = round(nmat(ii,onsetSec) / dt) + 1;
    toIdx   = round(sum(nmat(ii,[onsetSec durSec])) / dt);
    
    proll(nmat(ii,p) - pitchOffset, fromIdx:toIdx) = ones(1, toIdx - fromIdx + 1);
end

end
