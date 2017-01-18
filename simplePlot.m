
%% SIMPLY SUPPORTED BEAM DEFLECTION PLOT
% Contributor: Andrew Loken
% Plots deflection curve of a simply supported beam given length, load intensity, total weight, elastic modulus, area moment of inertia and deflection limit.
% Variables: L = length; F = point load intensity; W = total weight of beam; E = elastic modulus; I = area moment of inertia; maxD = deflection limit

function[returnDeflection,maxPossibleTotal] = simplePlot(L,F,W,E,I,maxD,maxF)

E = E * 10^9;
x = linspace(0,L);
x1 = linspace(0,L/2);
xR = linspace(L/2,0);

deflectionPL1 = -((F*x1)/(12*E*I)).*(.75*L^2-x1.^2)*1000;                   % Calculates deflection curve from load from x = 0 to L/2
deflectionSW = -(((W/L)*x)/(24*E*I)).*(L^3-2*L*x.^2+x.^3)*1000;             % Calculates deflection curve from self weight over entire beam
deflectionSW1 = -(((W/L)*x1)/(24*E*I)).*(L^3-2*L*x1.^2+x1.^3)*1000;         % Calculates deflection curve from self weight over x = 0 to L/2

deflection1 = deflectionPL1 + deflectionSW1;                                % Calculates total deflection from x = 0 to L/2

deflectionPLMax = -((F*(L/2))/(12*E*I)).*(.75*L^2-(L/2).^2);
deflectionSWMax = -(((W/L)*(L/2))/(24*E*I)).*(L^3-2*L*(L/2).^2+(L/2).^3);
returnDeflection = deflectionPLMax + deflectionSWMax;

plot(x,deflectionSW,'y')                                                    % Plots deflection from self weight
hold on
plot(x1,deflectionPL1,'g')                                                  % Plots deflection from point load over first half of beam
plot(x1,deflection1,'b','linewidth',2)                                      % Plots total deflection from point load over first half of beam
limit = refline(0,-maxD);                                                   % Displays max deflection limit set by user
limit.Color = 'r';
plot(xR+L/2,deflectionPL1,'g')                                              % Plots mirrored point load deflection curve over second half of beam (symmetry of load)
plot(xR+L/2,deflection1,'b','linewidth',2)                                  % Plots mirrored total deflection curve over second half of beam

deflectionPL1max = -((maxF*(L/2))/(12*E*I)).*(.75*L^2-(L/2).^2);
deflectionSWmax = -(((W/L)*(L/2))/(24*E*I)).*(L^3-2*L*(L/2).^2+(L/2).^3);
maxPossibleTotal = deflectionPL1max + deflectionSWmax;                      % Calculates maximum possible deflection (for F = max)
axis([0 L 1.1*1000*maxPossibleTotal 0])                                     % Scales axis: x in meters, y in millimeters

title('Simply Supported Beam Deflection')
xlabel('Beam Length [m]')
ylabel('Deflection [mm]')

legend('Self Weight', 'Point Load', 'Total', 'Limit')



end