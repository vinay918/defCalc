
%% RECTANGULAR BEAM AREA MOMENT OF INERTIA CALCULATOR
% Contributor: Andrew Loken
% Calculates area moment of inertia for a rectangular beam.
% Variables: b = base width; h = height

function[I] = rectangularMOI(b,h)

    I = (1/12)*b*h^3;
    
end

