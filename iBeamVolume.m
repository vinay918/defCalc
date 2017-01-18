
%% I-BEAM WEIGHT CALCULATOR 
% Contributor: Andrew Loken
% Calculates weight of I-Beam with volume calculation and material density.
% Variables: L = beam length; b = base width; wH = web height; fH = flange height; t = web thickness; density = beam material density;

function[volume] = iBeamVolume(L,b,wH,fH,t)
    
    xSectionArea = 2*fH*b + wH*t;
    volume = xSectionArea*L;
    
end
