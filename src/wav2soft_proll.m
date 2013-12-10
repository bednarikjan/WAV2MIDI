function soft_proll = wav2soft_proll(wav)
% soft_proll = wav2soft_proll(wav)
%
% WAV2SOFT_PROLL transforms WAV file to soft-decision piano-roll which
% is output of plca_piano() function.
%
% INPUTS
%   wav             WAV file name
%   thresh          threshold
%   snl             shortest-note-length (for post-processing)
%
% OUTPUTS
%   soft_proll      sotft-decision piano-roll matrix
%
% Date: 2.4.2013
% Author: Jan Bednarik
%

% import comon constants
constants;

% load signal
[s wavFs] = wavread(wav);

if wavFs ~= Fs
    error(['Wrong sampling frequency of the signal. ',                  ...
           'Found out %d Hz, expected %d Hz'], Fs_real, Fs);
end

% zero pad signal, if it's last segment is shorter than window length 
% (bec.of spectrogram())
if mod(length(s), segSecs * Fs) < wLen, s = [s; zeros(2*wLen,1)]; end

segs        = ceil(length(s) / Fs / segSecs);   % number of segments
segSamples  = segSecs * Fs;                     
segFrames   = fix(Fs * segSecs / (wLen * (1 - oLap)) - 1);

% add white gaussian noise to the signal (to get rid of zeros)
gn = wgn(1,length(s),0);
gn = gn / (max(abs(gn)) / min(abs(s(s ~= 0)))) / 1000;                
s  = s + gn';

% Pt matrix
Pt = zeros(pKeys,1);

% sum over spectrogram of the whole signal
specSum = 0; 

% compute PLCA for each signal segment
for ii = 1:segs
    fromSample = ((ii - 1) * segSamples) + 1;    
    if ii < segs; 
        toSample = fromSample + segSamples - 1;        
    else
        toSample = length(s);        
    end    
    
    [PtSeg Pz w] = plca_piano(s(fromSample:toSample),                   ...
                              Fs, wLen, oLap, pKeys, EMsteps);    
    specSum = specSum + w;    
    
    % weighing each time marginal with it's apriori
    PtSeg = bsxfun(@mtimes, PtSeg', Pz)';   
    PtSeg = PtSeg * w;
    
    % soft-decision piano-roll matrix
    Pt = [Pt PtSeg];  
end

Pt = Pt(:,2:end);
Pt = Pt / specSum;  

soft_proll = Pt;

end
