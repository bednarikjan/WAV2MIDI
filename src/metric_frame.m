function [Etot, Esubs, Emiss, Efa] = metric_frame(prmR, prmS)
% [Etot, Esubs, Emiss, Efa] = metric_frame(prmR, prmS)
% 
% Computes frame-level comparison between reference and system output 
% piano-roll matrix. Results multiplied by 100 would represent
% an average perentual score per single frame.
%
%
% INPUTS:
%   prmR            reference piano-roll matrix
%   prmS            system output piano-roll matrix
%
% OUTPUTS:
%   Etot            Total error score
%   Esubs           Substitution error
%   Emiss           Miss error
%   Efa             False alarm error
%
% Date: 2.4.2013
% Author: Jan Bednarik
%

Nref    = sum(prmR);
Nsys    = sum(prmS);
Ncorr   = sum(and(prmR, prmS));
NrefSum = sum(Nref);

Etot  = sum(max(Nref, Nsys) - Ncorr) / NrefSum;
Esubs = sum(min(Nref, Nsys) - Ncorr) / NrefSum;
Emiss = sum(max(0, Nref - Nsys))     / NrefSum;
Efa   = sum(max(0, Nsys - Nref))     / NrefSum;

end
