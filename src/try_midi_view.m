function try_midi_view(soft_proll, thresh, snl)
% function try_midi_view(soft_proll, thresh, snl)
%
% TRY_MIDI_VIEW converts soft-decision piano-roll matrix to piano-roll
% matrix and displays it.
%
% INPUTS
%   soft_proll          soft-decision piano-roll matrix
%   thresh              threshold
%   snl                 shorte note length (post-processing)
%
% Date: 2.4.2013
% Author: Jan Bednarik
%

% importing common constants
constants;

% get piano-roll matrix
proll = soft_proll2proll(soft_proll, thresh, snl);

% piano-roll time frame lnegth
dt = (wLen * (1 - oLap)) / Fs; 

% get note matrix
nmat = proll2nmat(proll, dt);

% view piano-roll
pianoroll(nmat);
