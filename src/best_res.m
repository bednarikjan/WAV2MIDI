function resVect = best_res(resMat, fa)
% function resVect = best_res(resMat, fa)
%
% BEST_RES picks the best results vector from matrix resVect. The best 
% result is considered to be that of the highest correct score (corr) 
% and the false alarm score of maximum value 'fa'.
%
%   INPUTS
%       resMat          results matrix
%       fa              the worst acceptable false alarm (percent)
%
%   OUTPUTS
%       resVect         the best results vector
%
% Date: 2.4.2013
% Author: Jan Bednarik
%
    
resMatNew = resMat(resMat(:,2) < fa,:);

% in case no result fits under given fa, increase fa by 5 percent
while isempty(resMatNew)
    fa = fa + 0.05;
    resMatNew = resMat(resMat(:,2) < fa,:);
end    

[~,I]   = max(resMatNew(:,1));
resVect = resMatNew(I,:);

end
