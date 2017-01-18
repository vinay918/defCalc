%GUI function to collect input of cross-section type

function [cType] =inputs2(~,~)
close all                                                                   %close previous figures
cType=0;
S.fig=figure('Visible','off','Name','defCalc','Color','white',...           %create figure
            'Position',[400,30,600,650]);

movegui(S.fig,'center');                                                    %move GUI to the center

set(S.fig,'Visible','On')                                                   %make GUI visible

setHeader;                                                                  %place header

axis1 = axes('units','normalized', ...                                      %create axes and load in image
            'position',[0.3 0.58 0.2 0.1]);

        imshow('circle.jpg');

        set(axis1,'handlevisibility','off', ...                                     %make axis invisible
            'visible','off')
        

        cb1 = uicontrol('style','checkbox', 'Value',0,...                           %create checkbox for circle            
                 'units','normalized','callback',@circ,...
                'position',[0.54 0.61 0.03 0.02]);         
        
axis2 = axes('units','normalized', ...                                      %load in another image (same as above)
            'position',[0.3 0.43 0.2 0.1]);

        imshow('iBeam.jpg');                                                        
set(axis2,'handlevisibility','off', ...
            'visible','off')           

cb2 = uicontrol('style','checkbox', 'Value',0,...                           %create checkbox for ibeam
                 'units','normalized','callback',@ibeam,...
                'position',[0.54 0.46 0.03 0.02]);        
        
axis3 = axes('units','normalized', ...                                      %same process as above for image 3
            'position',[0.3 0.28 0.2 0.1]);
imshow('rectangular beam.jpg');
set(axis3,'handlevisibility','off', ...
            'visible','off')
        
cb3 = uicontrol('style','checkbox', 'Value',0,...                           %checkbox for square
                 'units','normalized',...
                'position',[0.54 0.32 0.03 0.02],...
                'callback',@square);              

S.script=uicontrol('Units','normalized','position',[0.2 0.75 0.6 0.03],...  %create text
                    'style','text',...
            'string','PLEASE SELECT THE TYPE OF CROSS SECTION OF BEAM:');

S.exit = uicontrol('style','pushbutton','units','normalized','string','Exit',...
            'position',[0.75 0.05 0.2 0.05],...                             %push button mapped to exit funcion
            'callback',@ex);
        
uicontrol(cb1);                                                             %make checkboxes active
uicontrol(cb2);
uicontrol(cb3);

uiwait(S.fig)                                                               %wait for figure to close before proceeding
        
        
    function [] = circ(~,~)                                                 %function to initialize cross-section Type as circle
        cType='circle';
        close(S.fig)
    end
    function [] = ibeam(~,~)                                                % same as above but for iBeam
        cType='iBeam'; 
        close(S.fig)
    end
    function [] =  square(~,~)                                              %same as above but for square
        cType='square';
        close(S.fig)
    end

    function [] = ex(~,~)                                                   %exit function
    cType=0;                                                                %initialize cType as 0
    close(S.fig)
    end
end