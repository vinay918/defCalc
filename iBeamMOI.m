
%% I-BEAM AREA MOMENT OF INERTIA CALCULATOR
% Contributor: Andrew Loken
% Calculates area moment of inertia (I) for an I-Beam cross section.
% Variables: wH = web height; b = base width; t = web thickness

function[I] = iBeamMOI(wH,b,t,h)

    I = (1/12)*(b*h^3 - wH^3*b + wH^3*t);
    
end
