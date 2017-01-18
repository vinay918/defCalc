
%% DEFLECTION CALCULATOR
% Contributors == lines 5-50, 71-77: Vinay Singh Baldev Singh; lines 53-66, 79-90: Andrew Loken

bigloop=1;                                                                  %loop for overall program for new search

while bigloop ==1
    
clear
bigloop=0;

load materials.mat;
x=gui1;                                                                     %calls first GUI

    if x==0                                                                 %if exit is selected in first GUI,x is iniitialized as 0 so that the script terminates                                                            
    clear
    clc
    return
    end
                                                                          
tem=3;                                                                     %initializes tem as 3 for loop
while tem==3                                                               %forms loop in case user wishes to change cross-section type
    
cType = inputs2;                                                           %calls 2nd GUI for user to input cross-section type
    if cType == 0                                                          %check if exit is selected
        clear 
        clc 
        return 
    end


tem=inputs4(cType);                                                          %calls 3rd GUI to confirm user selection of cross-section type

    if tem== 0                                                                   %check if exit is selected and terminates if so
    clear 
    clc
    return
    end
end


loop=1;
while loop==1
[L,b,h,fH,t,maxD,maxF,ex,loop]=inputs3(cType);                             %calls 4th GUI for user to input additional information
if strcmp(cType,'circle')==1                                               %if circle is selected initialize diameter to equal width
    d=b;
elseif strcmp(cType,'iBeam')==1                                            %if iBeam is selected, calculate an additional parameter for calculation
    wH=h-(2*fH);                                                           %of web height
end

end
    if ex==1                                                               %check if exit is selected
        clear 
        clc
        return
    end

    
switch cType
    case 'square'
        V = rectangularVolume(L,b,h);
        I = rectangularMOI(b,h);
        cType = 'Rectangular Beam';
    case 'circle'
        V = circularVolume(L,d);
        I = circularMOI(d);
        cType = 'Circular Beam';
    case 'iBeam'
        V = iBeamVolume(L,b,wH,fH,t);
        I = iBeamMOI(wH,b,t,h);
        cType = 'I-Beam';
end

%materialDisplay = figure;
%repeatButton = uicontrol('Style','pushbutton','units','normalized','position',[.9 .05 .05 .05],'String','Next Material');

loopy=1;
count=1;
while loopy==1                                                             %loop for new materials
loopy=0;
[ex,type]=inputs5(materials);                                              %5th GUI to display table of materials and allow user to select material

if ex==1                                                                   %again, check if exit is selected
    clc
    clear
    return
end

selectedMaterial=materials(type);                                          %stores the structure that the user selected
density = selectedMaterial.Density;

W = V * density;
E = selectedMaterial.Modulus;
materialName = selectedMaterial.Name;

[maxC, maxS, loopy] = deflectionDisplay(L,W,E,I,maxF,maxD,materialName,cType);
unitCost = selectedMaterial.Cost;
totalCost = unitCost * W;

end                                                                        %close new material loop

if loopy==2
bigloop=materialDisplay(L,W,V,unitCost,totalCost,materialName,E,density,... %get value of big loop to know if user wants to re-run program
        maxD,maxF,maxC,maxS,cType);
end

end                                                                         %close big loop for whole program


        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    

        