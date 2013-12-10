function try_midi_sound(soft_proll, thresh, snl, fromS, toS)
% function try_midi_sound(soft_proll, thresh, snl, fromS, toS)
%
% TRY_MIDI_SOUND converts soft-decision piano-roll matrix to piano-roll
% matrix and plays it out loud from time 'fromS' to time 'toS'. If
% 'fromS' and 'toS' arguments are not specified, the whole piano-roll
% is played.
%
% INPUTS
%   soft_proll          soft-decision piano-roll matrix
%   thresh              threshold
%   snl                 shorte note length (post-processing)
%   fromS               start playing (second) (optional)
%   toS                 stop  playing (second) (optional)
%
% Date: 2.4.2013
% Author: Jan Bednarik
%

% importing common constants
constants;

if nargin < 4
    % start from 0 sec
    fromS = 0;    
end

% get piano-roll matrix
proll = soft_proll2proll(soft_proll, thresh, snl);

% piano-roll time frame lnegth
dt = (wLen * (1 - oLap)) / Fs; 

% get note matrix
nmat = proll2nmat(proll, dt);

if nargin < 5
    % play until end
    toS = nmat(end,6) + nmat(end,7);
end

% pick just the part of song wanted
nmat = nmat(nmat(:,6) <= toS,:);
nmat = shift(nmat, 'onset', -fromS, 'sec');

% play piano-roll
playsound(nmat);

end
