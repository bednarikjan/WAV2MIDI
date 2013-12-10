%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% TEST_DEMO demonstrates how success rate of system WAV2MIDI can be
% measured. Tests expects following folder structure:
%
%   Folder 'soundDir' contains all WAV files and their reference
%   MIDI files.
%
%   Folder 'auxdataDir' will contain computed soft-decision piano-roll
%   matrices and results matrices.
%
%   Folder 'resultsDir' will contain results text files for both tests.
%
% TEST1
%   Goes through all WAV files, computes their piano-roll matrix
%   using default threshold and snl (see constants.m) and compare
%   them to their reference MIDI files. It then prints the results
%   in format:
%       corr  fa  is  ex  Etot  Esubs  Emiss  Efa
%
% TEST2
%   The same as test1 but first it estimates the best possible 
%   threshold and snl to obtain best results (see test2.m)
%
% Date: 2.4.2013
% Author: Jan Bednarik
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% import common constants
constants;

% paths to directories related to testing
soundDir   = '..\test\sound';           % WAV and reference MIDI files
auxdataDir = '..\test\auxdata';         % soft piano-roll matrices and results matrices
resultsDir = '..\test\results';         % results text files

% results text file names
test1fname = 'test1.txt';
test2fname = 'test2.txt';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Get piano-roll matrices of all test WAV files and store them to
% directory 'auxdataDir'
content = ls(soundDir);        
content = content(3:end,:);

for ii = 1:size(content,1)
    % process file
    fileName = content(ii,1:find(content(ii,:) == '.', 1, 'last') + 3);
    name = fileName(1:end-4);
    suff = fileName(end-3:end);

    % check for right file
    if strcmp(suff, '.wav')        
        spr = wav2soft_proll([soundDir '\' fileName]);                                
        save([auxdataDir, '\', name], 'spr');
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% TEST 1

thresh = defThreshold;
snl    = defShortNoteLength;

% get results for each file and saves it to text file
fID = fopen([resultsDir '\' test1fname], 'a');
print_res_header(fID);
test1(soundDir, auxdataDir, fID, thresh, snl);
fclose(fID);

% print overal results
fID    = fopen([resultsDir '\' test1fname], 'r');
fgetl(fID);                                     % remove header
resCel = textscan(fID, '%s%f%f%f%f%f%f%f%f'); % get results (columns) into cell array
fclose(fID);

resMat  = cell2mat(resCel(2:end));
results = 100*(sum(resMat)  / size(resMat, 1));
fprintf('--- TEST1 ---\n');
fprintf('%2.2f   %2.2f   %2.2f   %2.2f   %2.2f   %2.2f   %2.2f   %2.2f\n\n', results);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% TEST 2

% get results for each file and saves it to text file
fID = fopen([resultsDir '\' test2fname], 'a');
print_res_header(fID);
test2(soundDir, auxdataDir, fID, worstFa);
fclose(fID);

% print overal results
fID    = fopen([resultsDir '\' test2fname], 'r');
fgetl(fID);                                     % remove header
resCel = textscan(fID, '%s%f%f%f%f%f%f%f%f'); % get results (columns) into cell array
fclose(fID);

resMat  = cell2mat(resCel(2:end));
results = 100*(sum(resMat)  / size(resMat, 1));
fprintf('--- TEST2 ---\n');
fprintf('%2.2f   %2.2f   %2.2f   %2.2f   %2.2f   %2.2f   %2.2f   %2.2f\n', results);
