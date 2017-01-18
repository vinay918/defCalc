
%% CANTILEVER DEFLECTION PLOT
% Contributor: Andrew Loken
% Description of steps outlined in simplePlot.m
% Plots deflection curve of cantilever beam given length, load intensity, total weight, elastic modulus, area moment of inertia and deflection limit.

% Variables: L = length; F = point load intensity; W = total weight of beam; E = elastic modulus; I = area moment of inertia; maxD = deflection limit

function[returnDeflection,maxPossibleTotal] = cantileverPlot(L,F,W,E,I,maxD,maxF)

E = E * 10^9;                                                                             
x = linspace(0,L);

deflectionPL = -((F*x.^2)/(6*E*I)).*(3*L-x)*1000;                                             
deflectionSW = -(((W/L)*x.^2)/(24*E*I)).*(x.^2+6*L^2-4*L*x)*1000;                            
deflection = deflectionPL + deflectionSW;

deflectionPLMax = -((F*L.^2)/(6*E*I)).*(3*L-L);
deflectionSWMax = -(((W/L)*L.^2)/(24*E*I)).*(L.^2+6*L^2-4*L*L);
returnDeflection = deflectionPLMax + deflectionSWMax;

plot(x,deflectionPL,'g')
hold on
plot(x,deflectionSW,'y')
plot(x,deflection,'b','linewidth',2)
limit = refline(0,-maxD);
limit.Color = 'r';

maxPossiblePL = -((maxF*(L.^2)/(6*E*I)).*(3*L-L));
maxPossibleSW = -(((W/L)*L.^2)/(24*E*I)).*(L.^2+6*L^2-4*L*L);  
maxPossibleTotal = maxPossiblePL + maxPossibleSW;
axis([0 L 1.1*1000*maxPossibleTotal 0])

title('Cantilever Beam Deflection')
xlabel('Beam Length [m]')
ylabel('Deflection [mm]')

legend('Point Load', 'Self Weight', 'Total', 'Limit');

end

