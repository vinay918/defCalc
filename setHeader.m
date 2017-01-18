%script to load in header and position it in the middle and at the top


S.ax = axes('units','normalized', ...                                       %load in axes for image
            'position',[0.15 0.75 0.7 0.2]);
                                                                            
uistack(S.ax,'bottom');                                                     % Move the background axes to the bottom

S.im=imread('neimage.jpg');                                                 % Load in a background image and display it using the correct colors
S.im=imresize(S.im,2);
S.hi = imagesc(S.im);
colormap gray
set(S.ax,'handlevisibility','off', ...                                      % Turn the handlevisibility off so that we don't inadvertently plot into the axes again
            'visible','off')                                                % Also, make the axes invisible