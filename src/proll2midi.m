function proll2midi(proll, outMidi)
% function proll2midi(proll, outMidi)
%
% PROLL2MIDI converts piano-roll matrix and stores it.
%
% INPUTS
%   proll               piano-roll matrix
%   outMidi             output MIDI file name
%
% Date: 2.4.2013
% Author: Jan Bednarik
%

% importing common constants
constants;

% piano-roll time frame lnegth
dt = (wLen * (1 - oLap)) / Fs; 

% convert piano-role matrix to note matrix
nmat = proll2nmat(proll, dt);

% store MIDI file
writemidi_seconds(nmat, outMidi);

end
