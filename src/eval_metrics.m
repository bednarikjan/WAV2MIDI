function resVect = eval_metrics(soundDir, auxdataDir, name, thresh, snl)
% function resVect = eval_metrics(soundDir, auxdataDir, name, thresh, snl)
%
% EVAL_METRICS evaluates both note-level and frame level metric and
% returns vector with all 8 resulting values.
%
% INPUTS
%   soundDir            directory with reference MIDI files
%   auxdataDir          directory with soft piano-roll matrices
%   name                name of file being tested
%   thresh              threshold
%   snl                 short note length (post-processing)
%
% Date: 2.4.2013
% Author: Jan Bednarik
%

% import common constants
constants;

% lnegth of piano-roll time frame
dt = (wLen * (1 - oLap)) / Fs; 

% load soft decision piano-roll
spr = load([auxdataDir '/' name '.mat']); spr = spr.spr;

% reference note matrix and piano-roll matrix
nmRef  = readmidi_java([soundDir '/' name '.mid']);
nmRef  = nmRef(nmRef(:,durSec) ~= 0, :);  % hack - some incorrect MIDI contains zero length notes
prmRef = nmat2proll(nmRef, dt);

 % make ref and sys matrices the same size (zero-pad smaller)
lenDif = size(prmRef,2) - size(spr,2); 
if lenDif > 0, spr =    [spr    zeros(size(spr,    1),  lenDif)];     
else           prmRef = [prmRef zeros(size(prmRef, 1), -lenDif)];
end

% make binary piano-roll matrix
proll = spr > thresh/prod(size(spr));

% system note matrix and piano-roll matrix
prmSys = rem_short(proll, snl);
nmSys  = proll2nmat(prmSys, dt);                               

% eval note-level and frame-level metrics
[corr, fa, is, ex]        = metric_note( nmRef,  nmSys );
[Etot, Esubs, Emiss, Efa] = metric_frame(prmRef, prmSys);                

% save results
resVect = [corr, fa, is, ex, Etot, Esubs, Emiss, Efa];        
    
end
