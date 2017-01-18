%GUI function to gather inputs of length, width and height

function [len,width,height,flangeHeight,webThickness,maxD,maxF,ex,loop] = inputs3(cType)

maxD=0;                                                                     %initializes x as 1 and everything else as 0 so that the program is terminated if figure is closed
maxF=0;
flangeHeight=0;
len=0;
width=0;
height=0;
webThickness=0;
loop=0;
ex=1;

S.fig=figure('Visible','off','Name','defCalc','Color','white',...           %create figure
            'Position',[400,30,600,650]);

movegui(S.fig,'center')                                                     %move figure to center of screen

setHeader;                                                                  %call script to set header
            
S.txt = uicontrol('style','text','units','normalized','string',...          %create text and place it
        'Please enter more information about the beam (meters unless stated):',...
        'position',[0.19 0.77 0.57 0.03]);   
    
S.maxF = uicontrol('style','edit',...                                     %create edit box for user input of max load
                 'units','normalized',...
                'position',[0.39 0.67 0.25 0.05],...
                'string','Maximum Load (N)');
            
S.maxD = uicontrol('style','edit',...                                     %create edit box for user input of max deflection
                 'units','normalized',...
                'position',[0.39 0.59 0.25 0.05],...
                'string','Maximum deflection(mm)');
            
S.length = uicontrol('style','edit',...                                     %create edit box for user input of length
                 'units','normalized',...
                'position',[0.39 0.51 0.25 0.05],...
                'string','Length of Beam');
            
S.width = uicontrol('style','edit',...                                      %edit box for width
                 'units','normalized',...
                'position',[0.39 0.43 0.25 0.05],...
                'string','Base Width or diameter');
            
            
            if strcmp(cType,'square')==1 || strcmp(cType,'iBeam')==1        %so that this field does not display for a circular cross-section
                
            S.height = uicontrol('style','edit',...                         %edit box for height
                        'units','normalized',...
                         'position',[0.39 0.35 0.25 0.05],...
                        'string','Height of beam');
            end
            
            
            if strcmp(cType,'iBeam')  == 1                                 %so that these fields only show up for iBeams
            
                S.fheight = uicontrol('style','edit',...                    %edit box for flange height
                 'units','normalized',...
                'position',[0.39 0.27 0.25 0.05],...
                'string','Flange height');
            
                S.wthick = uicontrol('style','edit',...                    %edit box for web thickness
                 'units','normalized',...
                'position',[0.39 0.19 0.25 0.05],...
                'string','Web thickness');
            end
            
           
S.next = uicontrol('style','pushbutton','units','normalized',...            %button to move on to next page
        'string','Next','position',[0.39 0.1 0.25 0.07],...
        'callback',@pb_call);


S.exit = uicontrol('style','pushbutton','units','normalized',...            %create button for exit callback
                    'string','Exit',...
                    'position',[0.77 0.05 0.2 0.05],...
                        'callback',@exi);

        set(S.fig,'Visible','on');                                          %make figure visible



uicontrol(S.maxF);                                                          %make this edit box active


uiwait(S.fig)                                                              % Prevent all other processes from starting until closed.

    function [] = pb_call( ~ , ~ )                                          %callback function to get input data and store them
        a=get(S.length, 'string'); 
        len=str2double(a);
        
        width=get(S.width,'string');
        width=str2double(width);
        
        maxD=get(S.maxD,'string');
        maxD=str2double(maxD);
        
        maxF=get(S.maxF,'string');
        maxF=str2double(maxF);
        
        ex=2;                                                              %initialize ex as 2 so that the script does not terminate
        
        
            if strcmp(cType,'iBeam')==1 || strcmp(cType,'square')==1        %takes into account if square or iBeam is selected
            height=get(S.height,'string');
            height=str2double(height);
        
            end
        
            
            if strcmp(cType,'iBeam')==1                                    %takes into account if iBeam is selected and collect its corresponding fields
            flangeHeight=get(S.fheight,'string');
            flangeHeight=str2double(flangeHeight);
        
            webThickness=get(S.wthick,'string');
            webThickness=str2double(webThickness); 
            end
        
            if (maxD==0||isnan(maxD)==1) && (len==0||isnan(len)==1) &&...   %if user does not input anything, loop is initialized as 1 so this GUI continues to loop
           (maxF==0||isnan(maxF)==1) &&(width==0||isnan(width)==1)&&...     %the loop is in the main script and depends on the output of the variable 'loop'
           (height==0||isnan(height)==1)&&...
           (flangeHeight==0||isnan(flangeHeight)==1)&&...
           (webThickness==0||isnan(webThickness)==1)
           
            loop=1;
        
            else                                                            %proceeds otherwise
        
            loop=0;
        
            end
        
    close(S.fig);                                                          %close figure to return value
        
    end



    function [] = exi(~,~)                                                  %function to initialize 'ex' as 1 and 'proceed' as 0 to be used in main script to terminate program
        ex=1;
        loop=0;
        close(S.fig)
    end


end