function [ex,type] = inputs5(materials)
ex=1;                                                                      %initializes ex as 1 and proceed as 0 so that the program is terminated if figure is closed
type=0;

close all                                                                   %close all previous figures                                                                  

S.fig=figure('Visible','off','Name','defCalc','Color','white',...           %create figure
            'Position',[400,30,600,650]);
setHeader                                                                   %sets Nebraska logo

movegui(S.fig,'center');                                                    %moves GUI to center

string1=uicontrol('Units','normalized','position',[0.27 0.7 0.5 0.04],...  %create and place text
                'style','text',...
                'string','Please select the material to continue');


stringbox1=uicontrol('Units','normalized','position',[0.1 0.62 0.2 0.05],... %create and place text for table column names
            'style','text',...
            'string','Material Name');
stringbox2=uicontrol('Units','normalized','position',[0.3 0.62 0.2 0.05],... 
            'style','text',...
            'string','Material Density (kg/m^3)');
stringbox3=uicontrol('Units','normalized','position',[0.5 0.62 0.2 0.05],... 
            'style','text',...
            'string','Elastic Modulus (GPa)');
stringbox4=uicontrol('Units','normalized','position',[0.7 0.62 0.2 0.05],... 
            'style','text',...
            'string','Cost($/kg)');



h=0.55;                                                                     %initialize h to adjust height in loop
for i = 1 : length(materials)                                              %loop to create button column of all material names
    
    S.pb(i)=uicontrol('style','pushbutton','units','normalized',...       
        'string',materials(i).Name,'position',[0.1 h 0.2 0.07],...
        'callback',@pb_call);
    tb1(i)=uicontrol('Units','normalized','position',[0.3 h 0.2 0.07],...  %create text columns of different material properties
           'style','text',...
           'string',materials(i).Density);
    tb2(i)=uicontrol('Units','normalized','position',[0.5 h 0.2 0.07],... 
           'style','text',...
           'string',materials(i).Modulus);
    tb3(i)=uicontrol('Units','normalized','position',[0.7 h 0.2 0.07],... 
           'style','text',...
           'string',materials(i).Cost);
    h=h-0.07;                                                               %reinitialize h for use in next iteration of loop
    
end


S.exit = uicontrol('style','pushbutton','units','normalized',...            %create exit button     
                    'string','Exit',...
                    'position',[0.37 0.05 0.27 0.05],...
                    'callback',@exi);
                
set(S.fig,'Visible','on');                                                 %make figure visible

uicontrol(S.pb(1));                                                       %make button active

uiwait(S.fig);                                                             %wait for figure to close

    function [] = exi(~,~)                                                 %function to initialize ex to 0 to be used in main script to exit
    ex=1;   
    close(S.fig)                                                           %close figure
    end



    function [] = pb_call(src,~,S)                                         %callback function to initialize type
        ex=0;                                                              %set ex to 0 so that the program does not terminate (used in main script)

        
        switch src.String                                                  %take into account the string of the source 
            case 'A36 Low Carbon Steel'                                    %to initialize type accordingly
                 type=1;
                
            case 'ASTM A992 Steel'
                type=2;
            case 'A514 Tempered Steel'
                type=3;
            case 'Concrete'
                type=4;
            case 'Reinforced Concrete'
                type=5;
            case 'High Performance Composite'
                type=6;
                
        end
        close all                                                           %closes figures so values can be returned to main script
    end


    

end
