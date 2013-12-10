function test2(soundDir, auxdataDir, fID, worstFa)
% function test2(soundDir, auxdataDir, fID, worstFa)
%
% TEST2 demonstrates how success-rate of system WAV2MIDI can be measured.
% In comparison to test1.m it does not use given threshold and snl 
% but it rather estimates the best threshold and snl as an average of
% best thresholds and snls of all tested files
%
% For each test file it gets it's piano-roll matrix from soft-decision
% piano-roll matrix (stored in 'auxdataDir') and compares it to
% the reference MIDI file (stored in 'resFile') multiple times with
% multiple combinations of threshold and snl. For each file it stores
% matrix containing row vecotrs of various results vectors. 
%
% It then estimates the best result vector for each file. It accounts
% for only those vectors that contain false alarm value (fa) lower then
% 'worstFa'.
%
% Finaly it gets the best threshold nad snl given all best results vectors
% and evaluates both metrics once again for each file and saves the results 
% to file 'fID'.
%
% INPUPTS
%   soundDir                directory with reference MIDI files
%   auxdataDir              directory with soft-decision piano-roll matrices
%   fID                     file ID to store results
%   worstFa                 highest value of false alarm acceptable
%
% Date: 2.4.2013
% Author: Jan Bednarik
%

% import common constants
constants;

%%% get and store results matrices for all tested files
content = ls(auxdataDir);        
content = content(3:end,:);

for ii = 1:size(content,1)
    % process file
    fileName = content(ii,1:find(content(ii,:) == '.', 1, 'last') + 3);
    name = fileName(1:end-4);
    suff = fileName(end-3:end);

    % check for right file
    if strcmp(suff,'.mat') && ~strcmp(name(end-4:end),'_res_')
        resMat = eval_metrics_mult(soundDir, auxdataDir, fileName);                
        
        % store results matrix
        save(strcat(auxdataDir, '/', name, '_res_'), 'resMat');                           
    end                                    
end

%%% get best threshold and snl given best results vectors of all files
% results matrix
resMat = zeros(1,10);
idx    = 1; 

content = ls(auxdataDir);        
content = content(3:end,:);

% get best results matrix
for ii = 1:size(content,1)
    % process file
    fileName = content(ii,1:find(content(ii,:) == '.', 1, 'last') + 3);
    name = fileName(1:end-4);
    suff = fileName(end-3:end);

    % check for right file
    if strcmp(suff,'.mat') && strcmp(name(end-4:end),'_res_')
        mat            = load(strcat(auxdataDir, '/', fileName)); 
        mat            = mat.resMat;                         
        resMat(idx, :) = best_res(mat, worstFa);
        idx = idx + 1;
    end                                    
end

bestThresh = round(sum(resMat(:, 9)) / size(resMat,1));
bestSnl    = round(sum(resMat(:,10)) / size(resMat,1));

%%% evauluates metrics for each file using best threshold and snl and store
% results to file fID
test1(soundDir, auxdataDir, fID, bestThresh, bestSnl);

end