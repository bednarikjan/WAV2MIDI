function soft_proll2midi(soft_proll, outMidi, thresh, snl)
% function soft_proll2midi(soft_proll, outMidi, thresh, snl)
%
% SOFT_PROLL2MIDI thresholds soft-decision piano-roll matrix, converts
% obtained piano-roll matrix to MIDI and stores it.
%
% INPUTS
%   soft_proll          soft-decision piano-roll matrix
%   thresh              threshold
%   snl                 shorte note length (post-processing)
%   outMidi             output MIDI file name
%
% Date: 2.4.2013
% Author: Jan Bednarik
%

% get piano-roll matrix
proll = soft_proll2proll(soft_proll, thresh, snl);

% store output MIDI
proll2midi(proll, outMidi);

end
