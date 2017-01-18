%Start menu

function [x] = gui1()
x=0;                                                                        %initializes x as 0 so that the program is terminated if figure is closed
close all                                                                   %close all previous figures

S.fig=figure('Visible','off','Name','defCalc','Color','white',...           %builds figure
            'Position',[400,60,600,650]);

movegui(S.fig,'center')                                                     %position figure in center of screen
setHeader;                                                                  %calls script that positions header

setlogo;                                                                    %calls script to position logo


pb = uicontrol('style','pushbutton',...                                     %create 'start' pudh button (mapped to start function)
                 'units','normalized',...
                'position',[0.4 0.2 0.2 0.1],...
                'string','Start',...
                'callback',{@start});
            
pb2 = uicontrol('style','pushbutton',...                                    %creates 'terms' pushbutton to open terms of use
                 'units','normalized',...
                'position',[0.4 0.1 0.2 0.05],...
                'string','Terms of use',...
                'callback',{@terms});

pb3 = uicontrol('style','pushbutton',...                                    %create 'exit' pushbutton
                 'units','normalized',...
                'position',[0.4 0.05 0.2 0.05],...
                'string','Exit',...
                'callback',{@ex});
           
set(S.fig,'Visible','On')                                                   %make figure visible

uiwait(S.fig);                                                              %wait for figure to close

    function [] = start(~,~)                                                %callback function to start program (move on to next GUI)
    x=1;                                                                    %initialize x for use in main script
    close(S.fig)                                                            %close figure so that the script continues
    end


    function [] = ex(~,~)                                                   %callback function to exit program
    x=0;
    close(S.fig)
    end


end  

