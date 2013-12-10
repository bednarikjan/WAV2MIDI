%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Common constants for wav2midi.m and all related functions.
%
% Date: 2.4.2013
% Author: Jan Bednarik
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% WAV2MIDI defaults
defThreshold          = 15;    % threshold (while creating piano-roll matrix)
defShortNoteLength    = 1;     % short note length (post-processing)

% saved soft decision piano-roll matrix variable name
sprName = 'spr';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% DEMO TEST settings
worstFa = 0.15;     % the worst false alarm rate acceptable

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% STFT
Fs   = 11025;       % Sampling frequency
wLen = 1024;        % Window length
oLap = 0.5;         % Window overlap (precent)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% PLCA
pKeys   = 88;   % Number of piano keys
EMsteps = 75;   % Number of plca iterations
segSecs = 60;   % length of one processed signal segment (seconds)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% MIDI
% MIDI matrix indexing according to MIDI toolbox
onsetBeat = 1;  % onset in beats; 
durBeat   = 2;  % duration in beats
mChannel  = 3;  % MIDI channel
p         = 4;  % pitch (C4 = 60)
vcity     = 5;  % velocity
onsetSec  = 6;  % onset time in seconds
durSec    = 7;  % duration in seconds

pitchOffset = 20;   % (A0 = 21 instead of 1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Testing
% threshold (for converting soft decision piano-roll to binary piano-roll)
thLow   = 2;    % lowest value for threshold
thStep  = 2;    % step
thHigh  = 30;   % highest value for threshold

% length of short notes to be removed
rmlLow  = 0;    % lowest value for snl
rmlStep = 1;    % step
rmlHigh = 5;    % highest value for snl
