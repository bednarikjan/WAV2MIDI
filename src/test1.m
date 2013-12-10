function test1(soundDir, auxdataDir, fID, thresh, snl)
% function test1(soundDir, auxdataDir, fID, thresh, snl)
%
% TEST1 demonstrates how success-rate of system WAV2MIDI can be measured.
% For each test file it gets it's piano-roll matrix from soft-decision
% piano-roll matrix (stored in 'auxdataDir') and compares it to
% the reference MIDI file (stored in 'resFile'). Finaly it prints
% results of note-level and frame-level matrix (8 values) to
% the file 'resFile'
%
% INPUPTS
%   soundDir                directory with reference MIDI files
%   auxdataDir              directory with soft-decision piano-roll matrices
%   fID                     file ID to store results
%   thresh                  threshold
%   snl                     short note length (post-processing)
%
% Date: 2.4.2013
% Author: Jan Bednarik
%

content = ls(auxdataDir);        
content = content(3:end,:);

for ii = 1:size(content,1)
    % process file
    fileName = content(ii,1:find(content(ii,:) == '.', 1, 'last') + 3);
    name = fileName(1:end-4);
    suff = fileName(end-3:end);

    % check for right file
    if strcmp(suff,'.mat') && ~strcmp(name(end-4:end),'_res_')
        resVect = eval_metrics(soundDir, auxdataDir, name, thresh, snl);                

        % store best results into file
        fprintf(fID,                                                    ...         
            ['%-30s %-13.4f %-13.4f %-13.4f %-13.4f '                   ...
             '%-13.4f %-13.4f %-13.4f %-13.4f\n'                        ...                
            ],                                                          ...
            name, resVect                                               ...
        );                            
    end                                    
end

end