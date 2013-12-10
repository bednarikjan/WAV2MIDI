function wav2midi(wav, midi, thresh, snl)
% function wav2midi(wav, midi, {thresh, {snl}})
%
% WAV2MIDI is main function of the whole WAV2MIDI system. It converts
% input WAV file with piano recording to output MIDI file. User can
% specify threshold and short-note-length (for post-processing) or
% the default values will be used (see constants.m).
%
% THRESHOLD
%   Default value fir threshold is 16. Recommended range is 0 - 100.
%
% SNL
%   Defualt value for short-note-length is 1. Reccomended range is 0 - 5.   
%
%
% INPUTS
%   wav             input  WAV  file name
%   midi            output MIDI file name
%   thresh          threshold (optional)
%   snl             short note length for post-processing (optional)
%
% Date: 2.4.2013
% Author: Jan Bednarik
%

% import common cosntants
constants;

% use defalut values for threshold and short note length    
if nargin < 4, snl    = defShortNoteLength; end
if nargin < 3, thresh = defThreshold;       end

% get soft-decision piano-roll matrix
softProll = wav2soft_proll(wav);

% threshold, postprocess and store resulting MIDI file
soft_proll2midi(softProll, midi, thresh, snl);

end
