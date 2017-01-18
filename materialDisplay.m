
%% MATERIAL DISPLAY
% Contributor: Andrew Loken
% Shows analysis of material beam for given conditions.

function[bigloop] = materialDisplay(L,W,V,unitCost,totalCost,materialName,E,density,maxD,maxF,maxC,maxS,cType,count)

bigloop=0;                                                                      

display = figure('Visible','off','Color','white','units','normalized','position',[0 .2 1 .8]);
movegui(display,'north')

imageAxes = axes('Visible','off','units','normalized','position',[.0155 .815 .07 .1]);
image = imread('neimageC.jpg');
imageDisplay = imshow(image);

title = uicontrol('style','text','units','normalized','position',[.1 .80 .2 .04],...
        'string','BEAM ANALYSIS','backgroundcolor','w','fontweight','bold',...
        'horizontalalign','left','fontsize',10);

% MATERIAL & BEAM INFO

materialTextInput = sprintf('%s %s',materialName,cType);
materialText = uicontrol('style','text','units','normalized','position',[.1 .7 .22 .05],...
        'string',materialTextInput,'fontweight','bold','backgroundcolor','w',...
        'horizontalalign','left');
frame1 = uicontrol('style','frame','units','normalized','position',[.095 .4 .22 .32]);    


modulusTextInput = sprintf('Elastic Modulus: %.2f GPa',E);
modulusText = uicontrol('style','text','units','normalized','position',[.1 .67 .12 .04],...
        'string',modulusTextInput,'horizontalalign','left');
densityTextInput = sprintf('Density: %.2f kg/m^3',density);
densityText = uicontrol('style','text','units','normalized','position',[.1 .64 .2 .04],...
        'string',densityTextInput,'horizontalalign','left');
volumeTextInput = sprintf('Volume: %.2f cubic meters',V);
volumeText = uicontrol('style','text','units','normalized','position',[.1 .61 .12 .04],...
        'string',volumeTextInput,'horizontalalign','left');
weightTextInput = sprintf('Weight: %.2f kg',W);
weightText = uicontrol('style','text','units','normalized','position',[.1 .58 .12 .04],...
        'string',weightTextInput,'horizontalalign','left');
unitCostTextInput = sprintf('Unit Cost: %.2f USD/kg',unitCost);
unitCostText = uicontrol('style','text','units','normalized','position',[.1 .55 .12 .04],...
        'string',unitCostTextInput,'horizontalalign','left');
totalCostTextInput = sprintf('Total Cost: %.2f USD',totalCost);
totalCostText = uicontrol('style','text','units','normalized','position',[.1 .52 .12 .04],...
        'string',totalCostTextInput,'horizontalalign','left');
  
% LOAD AND DEFLECTION ANALYSIS

title2 = uicontrol('style','text','units','normalized','position',[.35 .7 .1 .05],...
        'string','Load & Deflection','backgroundcolor','w','fontweight','bold',...
        'horizontalalign','left');
frame2 = uicontrol('style','frame','units','normalized','position',[.345 .45 .35 .27]);
maxDeflectionLimitTextInput = sprintf('Allowable Deflection: %.2f mm',maxD);
maxDeflectionLimitText = uicontrol('style','text','units','normalized','position',[.35 .67 .25 .04],...
        'string',maxDeflectionLimitTextInput,'horizontalalign','left');
maxForceTextInput = sprintf('Maximum Load Intensity: %.2f N',maxF);
maxForceText = uicontrol('style','text','units','normalized','position',[.35 .64 .25 .04],...
        'string',maxForceTextInput,'horizontalalign','left');
maxCDefTextInput = sprintf('Maximum Deflection, Cantilever: %.2f mm @ length = L',maxC*-1000);
maxCDefText = uicontrol('style','text','units','normalized','position',[.35 .61 .33 .04],...
        'string',maxCDefTextInput,'horizontalalign','left');
maxSDefTextInput = sprintf('Maximum Deflection, Simply Supported: %.2f mm @ length = L/2',maxS*-1000);
maxSDefText = uicontrol('style','text','units','normalized','position',[.35 .58 .33 .04],...
        'string',maxSDefTextInput,'horizontalalign','left');
    
if maxC > maxD
    safetyCheckC = 'Cantilever beam is not safe under these conditions.';
else
    safetyCheckC = 'Cantilever beam is safe under these conditions.';
end
if maxS > maxD
    safetyCheckS = 'Simply supported beam is not safe under these conditions.';
else
    safetyCheckS = 'Simply supported beam is safe under these conditions.';
end

safetyC = uicontrol('style','text','units','normalized','position',[.35 .5 .25 .04],...
        'string',safetyCheckC,'horizontalalign','left','fontweight','bold');
safetyS = uicontrol('style','text','units','normalized','position',[.35 .47 .25 .04],...
        'string',safetyCheckS,'horizontalalign','left','fontweight','bold');

endButton = uicontrol('style','pushbutton','units','normalized','position',...
        [.9 .05 .05 .04],'string','Exit','Callback',@endFcn);
repeatButton =  uicontrol('style','pushbutton','units','normalized','position',...
        [.825 .05 .07 .04],'string','New Search','Callback',@newMaterialFcn);
    
display.Visible = 'on';

uiwait(display)

function[] = endFcn(~,~)
    bigloop=0; %initialize bigloop to exit the loop and end the program.
    close(display)
end

function [] = newMaterialFcn(~,~)
    bigloop=1;
    close(display)

end

end


