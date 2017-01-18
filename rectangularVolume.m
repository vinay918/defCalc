
%% RECTANGULAR BEAM WEIGHT CALCULATOR
% Contributor: Andrew Loken
% Calculates weight of rectangular beam with volume calculation and material density.
% Variables: L = beam length; b = base width; h = height; density = beam material density;

function[volume] = rectangularVolume(L,b,h)

    xSectionArea = b*h;
    volume = xSectionArea*L;
    
end
