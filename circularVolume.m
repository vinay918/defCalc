
%% CIRCULAR BEAM VOLUME CALCULATOR
% Contributor: Andrew Loken
% Calculates volume of circular beam.
% Variables: L = beam length; d = diameter

function[volume] = circularWeight(L,d)

    r = d/2;
    xSectionArea = pi*r^2;
    volume = xSectionArea*L;
    
end
