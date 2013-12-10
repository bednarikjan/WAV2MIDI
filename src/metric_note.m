function [corr, fa, is, ex] = metric_note(nmR, nmS)
% function [corr, fa, is, ex] = metric_note(nmR, nmS)
% 
% Compares the reference and system output note matrix (MIDI matrix).
%
% INPUTS:
%   nmR             reference note matrix
%   nmS             system output note matrix
%
% OUTPUTS:
%   corr            Correctly recognized notes to correct notes ratio
%   fa              False alarm notes to correct notes ratio
%   is              intersection between ref and correctly recognized notes (percent)
%   ex              excess of correctly recognized notes over ref notes (percent)
%
% Date: 2.4.2013
% Author: Jan Bednarik
%

% importing common constants
constants;  

% initialization
hit = 0;
is  = 0;             
ex  = 0;           

% sort note matrices according to pitches
[~, IX] = sort(nmR(:,p));
nmR = nmR(IX, :);
[~, IX] = sort(nmS(:,p));
nmS = nmS(IX, :);

for note = unique(nmS(:,p))'    % all detected pitches
    pIdxSys = find(nmS(:,p) == note)';
    pIdxRef = find(nmR(:,p) == note)';
    
    for ns = pIdxSys        % note system
        startS = nmS(ns,onsetSec);
        endS   = sum(nmS(ns,[onsetSec durSec]));        
        
        for nr = pIdxRef    % note reference                        
            startR = nmR(nr,onsetSec);            
            endR   = sum(nmR(nr,[onsetSec durSec]));
            durR   = endR - startR;
            
            if durR == 0, break; end    % in case of incorrect MIDI file
            
           % HIT
           if ((startS >= startR - 0.1) && (startS <= startR) && (endS   >= startR)) ||            ...
              ((startS <= startR + 0.1) && (startS >  startR) && (startS <  endR  ))

                hit = hit + 1;                                                                
                is  = is  + (min(endR, endS) - max(startR, startS))            / durR;
                ex  = ex  + sum([max(0, endS - endR) max(0, startR - startS)]) / durR; 
                
                pIdxRef(pIdxRef == nr) = []; % delete idx of hit note from ref nmat
                break;
            end            
        end
    end    
end

corr = hit / size(nmR,1);
fa   = (size(nmS,1) - hit) / size(nmR,1);
is   = is / hit;
ex   = ex / hit;

end
