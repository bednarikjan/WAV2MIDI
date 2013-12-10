function print_res_header(fID)
% function print_res_header(fID)
%
% PRINT_RES_HEADER prints results header in file fID.
%
%   INPUTS
%       fID             output file
%
% Date: 2.4.2013
% Author: Jan Bednarik
%

% print header
    fprintf(fID,                                                        ...
      ('%-29s%-14s%-14s%-14s%-14s%-14s%-14s%-14s%-14s\n'),              ...        
       'file name',                                                     ...
       '| correct',   '| false alarm', '| intersect', '| excess',       ...
       '| Etot',      '| Esubs',       '| Emiss',     '| Efa'           ...       
    );

end
