function resMat = eval_metrics_mult(soundDir, auxdataDir, fileName)
% function resMat = eval_metrics_mult(soundDir, auxdataDir, fileName)
%
% EVAL_METRICS_MULT evaluates both note-level and frame-level metric for
% the file 'fileName' multiple times with various combinations of 
% threshod and snl. Finay it results matrix with roew results vecotrs.
%
% Date: 2.4.2013
% Author: Jan Bednarik
%

% common constants
constants;

% splitting file name into name and suffix
name = fileName(1:end-4);
suff = fileName(end-2:end);

% Prealocating results matrix 'res' and settings matrix 'settings'
thTests  = fix((thHigh  - thLow ) / thStep ) + 1;
rmlTests = fix((rmlHigh - rmlLow) / rmlStep) + 1;

res      = zeros(thTests * rmlTests, 8);    % [corr, fa, is, ex, Etot, Esubs, Emiss, Efa]
settings = zeros(thTests * rmlTests, 2);    % [threshold snLen]

% load soft decision piano-roll
spr = load([auxdataDir '/' name '.mat']); spr = spr.spr;

% lnegth of piano-roll time frame
dt = (wLen * (1 - oLap)) / Fs; 

% reference note matrix and piano-roll matrix
nmRef  = readmidi_java([soundDir '/' name '.mid']);
nmRef  = nmRef(find(nmRef(:,durSec) ~= 0), :);  % hack - some incorrect MIDI contains zero length notes
prmRef = nmat2proll(nmRef, dt);

 % make ref and sys matrices the same size (zero-pad smaller)
lenDif = size(prmRef,2) - size(spr,2); 
if lenDif > 0, spr =    [spr    zeros(size(spr,    1),  lenDif)];     
else           prmRef = [prmRef zeros(size(prmRef, 1), -lenDif)];
end

% init test settings
threshold = thLow;          % threshold
snLen     = rmlLow;         % short note length

% evaluate metrics
for ii = 1:thTests       
    snLen = rmlLow;
    
    proll = spr > threshold/prod(size(spr));
    
    for jj = 1:rmlTests                
        % system note matrix and piano-roll matrix
        prmSys = rem_short(proll, snLen);
        nmSys  = proll2nmat(prmSys, dt);                               
        
        % eval note-level and frame-level metrics
        [corr, fa, is, ex]        = metric_note( nmRef,  nmSys );
        [Etot, Esubs, Emiss, Efa] = metric_frame(prmRef, prmSys);                
        
        % save results
        idx              = (ii - 1) * rmlTests + jj;
        res(idx, 1:8)    = [corr, fa, is, ex, Etot, Esubs, Emiss, Efa];
        settings(idx, :) = [threshold, snLen];   
        
        % update snLen
        snLen = snLen + rmlStep;                
    end
    
    % update threshold
    threshold = threshold + thStep;
end

% return results matrix
resMat = [res settings];

end
