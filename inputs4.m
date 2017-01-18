%GUI function to display user selection of cross-section

function [proceed] =inputs4(cType)
proceed=0;                                                                 %initializes proceed as 0 so that the program is terminated if figure is closed

close all                                                                   %close all previous figures                                                                  

S.fig=figure('Visible','off','Name','defCalc','Color','white',...           %create figure
            'Position',[400,30,600,650]);

movegui(S.fig,'center');                                                    %position figure in the middle of screen

set(S.fig,'Visible','On')                                                   %make figure visible

setHeader;                                                                  %call script to place header



S.script=uicontrol('Units','normalized','position',[0.29 0.73 0.4 0.05],... %create and place text
                    'style','text',...
                    'string','Your selection:');
                

S.previous = uicontrol('style','pushbutton','units','normalized',...        %create 'previous' button       
                    'string','Previous',...
                    'position',[0.37 0.25 0.27 0.08],...
                    'callback',@no);
                
S.next = uicontrol('style','pushbutton','units','normalized',...            %create 'next' button       
                    'string','Next',...
                    'position',[0.37 0.15 0.27 0.08],...
                    'callback',@cont);
                
S.exit = uicontrol('style','pushbutton','units','normalized',...            %create exit button
                    'string','Exit',...
                    'position',[0.37 0.05 0.27 0.05],...
                    'callback',@ex);
 

S.text2=uicontrol('Units','normalized','position',[0.4 0.57 0.2 0.03],...  %create and place text
                    'style','text',...
                    'string','Cross section type');

 
 S.axis2=axes('units','normalized',...                                      %create axes to place selected image
                'position',[0.45 0.45 0.1 0.1]);
            
     switch cType                                                           %loads image according to input
         case 'square' 
             B=imread('rectangular beam.jpg');
         case 'iBeam'
             B=imread('iBeam.jpg');
         case 'circle'
             B=imread('circle.jpg');
     end
     imshow(B);                                                             %displays image
     set(S.axis2,'handlevisibility','off')
    
    
uiwait(S.fig);                                                              %waits for callback function to close program

    
    function [] = cont(~,~)                                                 %initializes proceed as 1 for use in main script to continue
    proceed=1;
    close(S.fig);
    end

    function [] = no(~,~)                                                   %function to initialize proceed as 3 to be used in main script to continue to loop
    proceed=3;
    close(S.fig)
    end

    function [] = ex(~,~)                                                   %function to initialize proceed as 0 to be used in main script to exit
    proceed=0;
    close(S.fig)
    end


end
