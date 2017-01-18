
%% DEFLECTION DISPLAY GUI
% Contributor: Andrew Loken
% GUI program for display of deflection curves and their relationship to load intensity F. User can manipulate load intensity with a slider. Importantinformation
% is displayed and updates in real time with change in load intensity.  Outputs are maximum deflections for both beams, in signed meters.

function[maxPossibleC,maxPossibleS,loopy] = deflectionDisplay(L,W,E,I,maxF,maxD,materialName,cType)

loopy=0; %for new material loop
display = figure('Visible','off','Color','white','units','normalized','Position',[0 .2 1 .8]);           % Initialize figure; hide display until finished.    
movegui(display,'north')

newMaterialButton = uicontrol('Style','pushbutton','Units','normalized',...                             % Button: select another material for analysis.
                          'Position',[.14 .815 .082 .04],'String','Select new material',...
                          'Callback',@newMaterialFcn);
endButton = uicontrol('Style','pushbutton','Units','normalized','Position',[.223 .815 .0777 .04],...     % Button: finish and view material comparison.    
                          'String','View Analysis','Callback',@finishFcn);

slider = uicontrol('Style','slider','Units','normalized','Position',[.315 .06 .05 .745],...              % Create slider for load intensity manipulation.
                          'Min',0,'Max',maxF,'Callback',@sliderFcn);
maxDisplay = uicontrol('Style','Text','BackgroundColor','white','Units','normalized',...                 % Label maximum load value at top of slider.
                          'Position',[.315 .805 .05 .03],'String',num2str(maxF));
minDisplay = uicontrol('Style','Text','BackgroundColor','white','Units','normalized',...                 % Label minimum load value at bottom of slider.
                          'Position',[.315 .015 .05 .04],'String','0');                                  
loadText = uicontrol('Style','Text','BackgroundColor','white','Units','normalized',...                   % Label slider as load intensity.
                          'Position',[.287 .9 .11 .04],'String','Load Intensity [N]',...
                          'FontWeight','bold');
loadValue = uicontrol('Style','Text','BackgroundColor','white','Units','normalized',...                  % Display current value of slider.
                          'Position',[.287 .87 .11 .03],'String','0',...    
                          'FontWeight','bold');
                      
noticeFrame = uicontrol('Style','Frame','Units','normalized','Position',[.0155 .6 .285 .2]);             % Lines 33-39 provide information about loading scheme.
simpleNotice = uicontrol('Style','text','units','normalized','position',[.03 .72 .25 .03],...
                          'String', 'For simply supported beam, load is applied at midpoint of beam.',...
                          'horizontalalignment','left');
cantileverNotice = uicontrol('Style','text','units','normalized','position',[.03 .65 .25 .03],...
                          'String', 'For cantilever beam, load is applied at terminal end of beam.',...
                          'horizontalalignment','left');    
                      
F = 0;                                                                                                   
subplot(2,1,1,'Position',[.43 .6 .55 .35])                                                               % Create subplot cluster for deflection curves.
[returnDeflectionS, maxPossibleS] = simplePlot(L,F,W,E,I,maxD,maxF);                                     % Plot pre-slider choice deflection curve for F=0;
subplot(2,1,2,'Position',[.43 .1 .55 .35])
[returnDeflectionC, maxPossibleC] = cantileverPlot(L,F,W,E,I,maxD,maxF);

beamType = sprintf('%s %s', materialName, cType);

textFrame = uicontrol('Style','Frame','Units','normalized','Position',[.0155 .06 .285 .52]);             % Lines 49-74 provide information about the plots.   
materialTitle = uicontrol('Style','text','units','normalized','position',[.019 .54 .2 .03],...
                          'String','Beam Type','fontweight','bold','horizontalalignment','left');
materialText = uicontrol('Style','text','units','normalized','position',[.019 .51 .25 .03],...
                          'String',beamType,'horizontalalignment','left');

simpleMaxTitle = uicontrol('Style','text','units','normalized','position',[.019 .4 .2 .03],...
                          'String','Max Simple Deflection [mm]','fontweight','bold',...
                          'horizontalalignment','left');
maxDeflectionSmm = -returnDeflectionS * 1000;                                                            % Conversion to mm.
simpleMax = uicontrol('Style','text','units','normalized','position',[.019 .37 .2 .03],...               % Display max deflection of SS beam for current load.
                          'String',num2str(maxDeflectionSmm),'horizontalalignment','left');

cantileverMaxTitle = uicontrol('Style','text','units','normalized',...
                          'position',[.019 .25 .2 .03],...
                          'String','Max Cantilever Deflection [mm]','fontweight','bold',...               
                          'horizontalalignment','left');
maxDeflectionCmm = -returnDeflectionC * 1000;                                                            % Conversion to mm.
cantileverMax = uicontrol('Style','text','units','normalized','position',[.019 .22 .2 .03],...           % Display max deflection of C beam for current load.
                          'String',num2str(maxDeflectionCmm),'horizontalalignment','left');

limitNotice = uicontrol('Style','text','units','normalized','position',[.019 .1 .2 .03],...
                          'String', 'Deflection Limit [mm]','fontweight','bold',...
                          'horizontalalignment','left');
limitValue = uicontrol('Style','text','units','normalized','position',[.019 .07 .2 .03],...
                          'String', num2str(maxD),'horizontalalignment','left');



imagePlaceAxes = axes('Units','normalized','Position',[.0155 .815 .07 .1],'Visible','off');              % Lines 78-80 read and place UNL ENGR logo on display.
unlENGRLogo = imread('neimageC.jpg');
imageDisplay = imshow(unlENGRLogo);

display.Visible = 'on';                                                                                  % Make display visible.

% CALLBACK FUNCTIONS --------------------------------------------------------------------------------------------------------------------------------------------

function[] = sliderFcn(~,~)                                                                              % Function called upon slider motion.
    
    value = get(slider,'Value');                                                                         % Obtain current value of slider after user release.
    set(loadValue,'String',num2str(value))                                                               % Write current value to current load display box.
    
    F = value;
    
    subplot(2,1,1,'Position',[.43 .6 .55 .35])                                                           % Re-create subplot cluster.
    returnDeflectionS = simplePlot(L,F,W,E,I,maxD,maxF);                                                 % Plot simple deflection curve for current slider value.
    subplot(2,1,2,'Position',[.43 .1 .55 .35])
    maxDeflectionC = cantileverPlot(L,F,W,E,I,maxD,maxF);                                                % Plot cant. deflection curve for current slider value.
    
    maxDeflectionSmm = -returnDeflectionS * 1000;                                                        % Conversion of current max simple deflection to mm.
    set(simpleMax,'String',num2str(maxDeflectionSmm));                                                   % Write current max simple deflection to info box.
    maxDeflectionCmm = -maxDeflectionC * 1000;                                                           % Conversion of current max cantilever deflection to mm.
    set(cantileverMax,'String',num2str(maxDeflectionCmm))                                                % Write current max cantilever deflection to info box.

    if maxDeflectionSmm > maxD || maxDeflectionCmm > maxD                                                % Displays warning message if def > maxD.
        warning = uicontrol('Style','text','BackgroundColor','red',...
                          'units','normalized',...
                         'position',[.155 .07 .14 .045],...
                         'string','Notice: Current deflection exceeds maximum allowable deflection.');
    else
        warning = uicontrol('Style','text','units','normalized',...
                         'position',[.155 .07 .14 .045]);
    end
end

function[] = newMaterialFcn(~,~)                                                                   % Function called upon 'new material' button press.
    
    loopy = 1; %initialize loopy as one to remain in loop
    close(display)
    
    
end

uiwait(display)

function[] = finishFcn(~,~)                                                                               % Function called upon 'finish' button press.
    
    loopy=2;
    close(display)
    
end

end
