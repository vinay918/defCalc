%script to load in logo and position it


S.ha = axes('units','normalized', ...                                       %create axes for image
            'position',[0.2 0.45 0.6 0.3]);

uistack(S.ha,'bottom');                                                     % Move the background axes to the bottom

S.I=imread('defCalcimg.jpg');                                               % Load in a background image and display it using the correct colors
S.I=imresize(S.I,2);
S.hi = imagesc(S.I);
colormap gray


set(S.ha,'handlevisibility','off', ...                                      % Turn the handlevisibility off so that we don't inadvertently plot into the axes again
            'visible','off')                                                % Also, make the axes invisible