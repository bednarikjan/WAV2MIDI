function mMat = proll2mmat(proll, dt, bpm)
% function mMat = proll2mmat(proll, dt, bpm)
%
% PROLL2NMAT converts piano-roll matrix obtained using PLCA to MIDI 
% note matrix in the format corresponding to MIDI toolbox.
%
%   proll       piano-roll matrix
%   dt          length of time frame in seconds
%   bpm         tempo beats per minute (not compulsory)
%
% Date: 2.4.2013
% Author: Jan Bednarik
%

constants;

% constants
defMChannel = 1;    % default MIDI channel
defVelocity = 64;   % default velocity
mMatCols    = 7;    % number of MIDI matrix columns
mMatRows    = 32;   % initial count of MIDI matrix rows
defBpm      = 60;   % default tempo (BPM)

if nargin < 3; bpm = defBpm; end

% fsm properties
state = 0;      % content of the current matrix cell
start = 0;      % start of current note (proll matrix column index)
mmi   = 1;      % indexing rows in MIDI matrix

quarter = 60/bpm;
mMat    = zeros(mMatRows, mMatCols);    % prealocating MIDI matrix

proll = [proll zeros(size(proll,1), 1)];

for r = 1:size(proll, 1)
    state = 0; start = 0;    
    for c = 1:size(proll, 2)
        
        % note appeares
        if     state == 0 && proll(r, c) == 1                            
            start = c;
            mMat(mmi, p)    = r + pitchOffset;  % pitch
            mMat(mmi, onsetSec) = (c - 1) * dt; % onset                                        
            state = 1;            
        
        % note ends
        elseif state == 1 && proll(r, c) == 0                                                         
            mMat(mmi, durSec) = (c - start) * dt;  % duration
            mmi = mmi + 1;
            state = 0;          
            
            if mmi > size(mMat,1); mMat = [mMat; zeros(size(mMat,1), mMatCols)]; end;
        end
        
    end
end

% remove trailing zero rows;
mMat = mMat(any(mMat,2),:);

% fill in common MIDI channel (1) and velocity (64)
mMat(:, mChannel) = defMChannel * ones(size(mMat,1),1);
mMat(:, vcity) = defVelocity * ones(size(mMat,1),1);

% fill in onset time and durations in beats
mMat(:, onsetBeat) = mMat(:, onsetSec) / quarter;
mMat(:, durBeat)   = mMat(:, durSec)   / quarter;

% sort MIDI matrix according to onsets times
[~, IX] = sort(mMat(:,onsetSec));
mMat = mMat(IX, :);

end
