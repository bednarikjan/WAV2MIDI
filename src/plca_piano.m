function [Pt Pz weight] = plca_piano(s, Fs, wLen, oLap, z, EMsteps)
% function [Pt Pz weight] = plca_piano(s, Fs, wLen, oLap, z, Pf, EMsteps, onset)
%
% PLCA_PIANO computes PLCA on given signal 's'. It returns matrix 'Pt' with
% estimated time marginals and vector of related aprioris 'Pz' and 
% the weight of the whole signal.
%
% INPUTS
%   s               input signal
%   Fs              sampling frequency
%   wLen            windows length (for spectrogram ())
%   oLap            window overlap (for spectrogram ())
%   z               number of latent variables (piano keys)
%   EMsteps         number of PLCA iterations
%
% OUTPUTS
%   Pt              matrix of estimated time marginals
%   Pz              vector of estimated aprioris
%   weight          weight of signal (sum over spectrogram)
%
% Date: 2.4.2013
% Author: Lukas Burget, Jan Bednarik
%

% Load pre-trained frequency marginals matrix.
fmMat = load('fmmat11khz.mat'); Pf = fmMat.fmMat;

% ground truth magnitude spectrogram
Px     = abs(spectrogram(s, wLen, fix(wLen*oLap), wLen, Fs));
weight = sum(sum(Px));
Px     = Px/sum(Px(:));

% Pz inititialization
Pz = ones(1,z)/z; 

% Pt inititialization
Pt = ones(z,size(Px,2))/size(Px,2);

% Pf normalization
Pf = bsxfun(@rdivide, Pf, sum(Pf));

% Spectrogram reconstruction
plca = @(Pz, Pf, Pt)  bsxfun(@times, Pf, Pz) * Pt;

for ii=1:EMsteps
  Rxz   = bsxfun(@times, permute(bsxfun(@times, Pf, Pz), [1,3,2]),      ...   
                         permute(Pt, [3,2,1]));
  Rxz   = bsxfun(@times, Rxz, 1./sum(Rxz,ndims(Rxz)));                                    
  PxPxz = bsxfun(@times, Px, Rxz);                                                      
  Pz    = squeeze(sum(sum(PxPxz)))';
  Pt    = bsxfun(@times, squeeze(sum(PxPxz, 1)), 1./Pz)';  
  %KL  = sum(sum(Px .* (log(Px) - log(plca(Pz, Pf, Pt)))));
  %[ii KL]
end

end
