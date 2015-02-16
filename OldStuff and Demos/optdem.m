function optdem(action)
%BANDEM Banana function minimization demonstration.
%   This demonstration shows the minimization         
%   of Rosenbrock's "banana function":                
%                                                           
%       f(x)= 100*(x(2)-x(1)^2)^2+(1-x(1))^2          
%                                                            
%   It is called the banana function because of       
%   the way the curvature bends around the            
%   origin. It is notorious in optimization examples  
%   because of the slow convergence which             
%   most methods exhibit when trying to solve         
%   this problem.                                     
%                                                            
%   This function has a unique minimum at the         
%   point x=[1, 1] where f(x)=0. We show here         
%   a number of techniques for its minimization       
%   starting at the point x=[-1.9, 2].                

%   Copyright 1990-2005 The MathWorks, Inc.
%   $Revision: 5.14.4.7 $  $Date: 2006/06/20 20:13:35 $
 
if nargin<1,
   action='initialize';
end;

if strcmp(action,'initialize'),
   figNumber=figure( ...
      'Name','Using the Optimization Toolbox', ...
      'NumberTitle','off', ...
      'Visible','off');
   axes( ...
      'Units','normalized', ...
      'Visible','off', ...
      'Position',[0.05 0.40 0.70 0.75]);
   
   %===================================
   % Set up the Comment Window
   top=0.35;
   left=0.05;
   right=0.75;
   bottom=0.05;
   labelHt=0.05;
   spacing=0.005;
   promptStr=str2mat(' ',...
      ' Press the buttons at the right to see examples of', ...
      ' Optimization Toolbox commands using medium-scale algorithms.');
   % First, the MiniCommand Window frame
   frmBorder=0.02;
   frmPos=[left-frmBorder bottom-frmBorder ...
         (right-left)+2*frmBorder (top-bottom)+2*frmBorder];
   uicontrol( ...
      'Style','frame', ...
      'Units','normalized', ...
      'Position',frmPos, ...
      'BackgroundColor',[0.5 0.5 0.5]);
   % Then the text label
   labelPos=[left top-labelHt (right-left) labelHt];
   uicontrol( ...
      'Style','text', ...
      'Units','normalized', ...
      'Position',labelPos, ...
      'BackgroundColor',[0.5 0.5 0.5], ...
      'ForegroundColor',[1 1 1], ...
      'String','Comment Window');
   % Then the editable text field
   txtPos=[left bottom (right-left) top-bottom-labelHt-spacing];
   txtHndl=uicontrol( ...
      'Style','edit', ...
      'Enable','inactive',...
      'HorizontalAlignment','left', ...
      'Units','normalized', ...
      'Max',10, ...
      'BackgroundColor',[1 1 1], ...
      'Position',txtPos, ...
      'Callback','optdem(''eval'')', ...
      'String',promptStr);
   % Save this handle for future use
   set(gcf,'UserData',txtHndl);
   
   %====================================
   % Information for all buttons
   labelColor=[0.8 0.8 0.8];
   top=0.95;
   left=0.80;
   btnWid=0.15;
   btnHt=0.08;
   % Spacing between the button and the next command's label
   spacing=0.02;
   
   %====================================
   % The CONSOLE frame
   frmBorder=0.02;
   yPos=0.05-frmBorder;
   frmPos=[left-frmBorder yPos btnWid+2*frmBorder 0.9+2*frmBorder];
   uicontrol( ...
      'Style','frame', ...
      'Units','normalized', ...
      'Position',frmPos, ...
      'BackgroundColor',[0.5 0.5 0.5]);
   
   %====================================
   % The BFGS button
   btnNumber=1;
   yPos=top-(btnNumber-1)*(btnHt+spacing);
   labelStr='BFGS';
   callbackStr='optdem(''demobutton'')';
   
   % Generic popup button information
   btnPos=[left yPos-btnHt btnWid btnHt];
   uicontrol( ...
      'Style','pushbutton', ...
      'Units','normalized', ...
      'Position',btnPos, ...
      'String',labelStr, ...
      'Callback',callbackStr, ...
      'UserData',btnNumber);
   
   %====================================
   % The DFP button
   btnNumber=2;
   yPos=top-(btnNumber-1)*(btnHt+spacing);
   labelStr='DFP';
   callbackStr='optdem(''demobutton'')';
   
   % Generic popup button information
   btnPos=[left yPos-btnHt btnWid btnHt];
   uicontrol( ...
      'Style','pushbutton', ...
      'Units','normalized', ...
      'Position',btnPos, ...
      'String',labelStr, ...
      'Callback',callbackStr, ...
      'UserData',btnNumber);
   
   %====================================
   % The STEEPEST DESCENT button
   btnNumber=3;
   yPos=top-(btnNumber-1)*(btnHt+spacing);
   labelStr='Steepest';
   callbackStr='optdem(''demobutton'')';
   
   % Generic popup button information
   btnPos=[left yPos-btnHt btnWid btnHt];
   uicontrol( ...
      'Style','pushbutton', ...
      'Units','normalized', ...
      'Position',btnPos, ...
      'String',labelStr, ...
      'Callback',callbackStr, ...
      'UserData',btnNumber);
   
   %====================================
   % The SIMPLEX button
   btnNumber=4;
   yPos=top-(btnNumber-1)*(btnHt+spacing);
   labelStr='Simplex';
   callbackStr='optdem(''demobutton'')';
   
   % Generic popup button information
   btnPos=[left yPos-btnHt btnWid btnHt];
   uicontrol( ...
      'Style','pushbutton', ...
      'Units','normalized', ...
      'Position',btnPos, ...
      'String',labelStr, ...
      'Callback',callbackStr, ...
      'UserData',btnNumber);
   
   %====================================
   % The GAUSS-NEWTON button
   btnNumber=5;
   yPos=top-(btnNumber-1)*(btnHt+spacing);
   labelStr='G-N';
   callbackStr='optdem(''demobutton'')';
   
   % Generic popup button information
   btnPos=[left yPos-btnHt btnWid btnHt];
   uicontrol( ...
      'Style','pushbutton', ...
      'Units','normalized', ...
      'Position',btnPos, ...
      'String',labelStr, ...
      'Callback',callbackStr, ...
      'UserData',btnNumber);
   
   %====================================
   % The LEVENBERG-MARQUARDT button
   btnNumber=6;
   yPos=top-(btnNumber-1)*(btnHt+spacing);
   labelStr='L-M';
   callbackStr='optdem(''demobutton'')';
   
   % Generic popup button information
   btnPos=[left yPos-btnHt btnWid btnHt];
   uicontrol( ...
      'Style','pushbutton', ...
      'Units','normalized', ...
      'Position',btnPos, ...
      'String',labelStr, ...
      'Callback',callbackStr, ...
      'UserData',btnNumber);
   
   %====================================
   % The INFO button
   uicontrol( ...
      'Style','push', ...
      'Units','normalized', ...
      'Position',[left bottom+btnHt+spacing btnWid btnHt], ...
      'String','Info', ...
      'Callback','optdem(''info'')');
   
   %====================================
   % The CLOSE button
   uicontrol( ...
      'Style','push', ...
      'Units','normalized', ...
      'Position',[left bottom btnWid btnHt], ...
      'String','Close', ...
      'Callback','close(gcf)');
   
   % Now uncover the figure
   set(figNumber,'Visible','on');
   
elseif strcmp(action,'demobutton'),
   method=get(gco,'UserData');
   txtHndl=get(gcf,'UserData');
   
   % Plotting the banana function
   plotbanana;
   plot3(-1.9,2,267.62,'ko', ...
      'MarkerSize',15, ...
      'LineWidth',2, ...
      'EraseMode','none');
   text(-1.9,2.2,267.62,'   Begin', ...
      'Color',[0 0 0], ...
      'EraseMode','none');
   plot3(1,1,0,'ko', ...
      'MarkerSize',15, ...
      'LineWidth',2, ...
      'EraseMode','none');
   text(0.8,1.4,0,'   End', ...
      'Color',[0 0 0], ...
      'EraseMode','none');
   x=[-1.9 2];
   % Uncomment the next line for random initial conditions
   %x=[4*rand-2 4*rand-1];
   
   OPTIONS=optimset('LargeScale','off','OutputFcn',@optdemOutFcn);

   % Turn off all messages, even if no convergence.
   OPTIONS = optimset(OPTIONS,'display','off');
   if method==1,
      str= ...
         [' Broyden-Fletcher-Goldfarb-Shanno         '  
         ' (Unconstrained quasi-Newton minimization)'];
      set(txtHndl,'String',str);
      GRAD='[2.*(2.*x(1).^3-2.*x(1).*x(2)+x(1)-1);2.*(x(2)-x(1).^2)]';
      f='(1-x(1).^2)+(x(2)-x(1).^2).^2';
      OPTIONS = optimset(OPTIONS,'gradobj','on','MaxFunEvals',200, ...
          'InitialHessType','scaled-identity');
      str2='[x,fval,exitflag,output] = fminunc({f,GRAD},x,OPTIONS);';
      [x,fval,exitflag,output] = fminunc({f,GRAD},x,OPTIONS);
      
   elseif method==2,
      str= ...
         [' Davidon-Fletcher-Powell                   '  
         ' (Unconstrained quasi-Newton minimization) '];
      set(txtHndl,'String',str);
      OPTIONS = optimset(OPTIONS,'HessUpdate','dfp','gradobj','on','MaxFunEvals', ...
          200,'InitialHessType','identity');
      GRAD='[100*(4*x(1)^3-4*x(1)*x(2))+2*x(1)-2; 100*(2*x(2)-2*x(1)^2)]';
      f='100*(x(2)-x(1)^2)^2+(1-x(1))^2';
      str2='[x,fval,exitflag,output] = fminunc({f,GRAD},x,OPTIONS);';
      [x,fval,exitflag,output] = fminunc({f,GRAD},x,OPTIONS);
      
   elseif method==3,
      str= ...
         [' Steepest Descent                '  
         ' (Unconstrained minimization)    '];
      set(txtHndl,'String',str);
      OPTIONS = optimset(OPTIONS,'HessUpdate','steepdesc','gradobj','on','MaxFunEvals',250);
      GRAD='[100*(4*x(1)^3-4*x(1)*x(2))+2*x(1)-2; 100*(2*x(2)-2*x(1)^2)]';
      f='100*(x(2)-x(1)^2)^2+(1-x(1))^2';
      str2='[x,fval,exitflag,output] = fminunc({f,GRAD},x,OPTIONS);';
      [x,fval,exitflag,output] = fminunc({f,GRAD},x,OPTIONS);
      
   elseif method==4,
      str= ...
         [' Nelder-Mead                         '  
         ' (Unconstrained simplex minimization)'];
      set(txtHndl,'String',str);
      OPTIONS = optimset(OPTIONS,'MaxFunEvals',200);
      f='[100*(x(2)-x(1)^2)^2+(1-x(1))^2]';
      str2='[x,fval,exitflag,output] = fminsearch(f,x,OPTIONS);';
      which fminsearch
      [x,fval,exitflag,output] = fminsearch(f,x,OPTIONS);
      
   elseif method==5,
      str= ...
         [' Gauss-Newton                '  
         ' (Least squares minimization)'];
      set(txtHndl,'String',str);
      OPTIONS = optimset(OPTIONS,'LevenbergMarq','off','MaxFunEvals',200,'Jacobian','on');
      JAC='[-20*x(1), 10; -1, 0]';
      f='[10*(x(2)-x(1)^2),(1-x(1))]';
      str2='[x,resnorm,residual,exitflag,output]= lsqnonlin({f,JAC},x,[],[],OPTIONS);';
      [x,resnorm,residual,exitflag,output]= lsqnonlin({f,JAC},x,[],[],OPTIONS);
      fval = resnorm;
      
   elseif method==6,
      str= ...
         [' Levenberg-Marquardt          '  
         ' (Least squares minimization) '];
      set(txtHndl,'String',str);
      OPTIONS = optimset(OPTIONS,'LevenbergMarq','on','MaxFunEvals',200,'Jacobian','on');
      JAC='[-20*x(1), 10; -1, 0]';
      f='[10*(x(2)-x(1)^2),(1-x(1))]';
      str2='[x,resnorm,residual,exitflag,output]= lsqnonlin({f,JAC},x,[],[],OPTIONS);';
      [x,resnorm,residual,exitflag,output]= lsqnonlin({f,JAC},x,[],[],OPTIONS);
      fval = resnorm;
   end;
   funEvals=sprintf(' Number of iterations: %g.  Number of function evaluations: %g.', output.iterations, output.funcCount);
   str=get(txtHndl,'String');
   str=str2mat(str,' ',str2,' ',funEvals);
   set(txtHndl,'String',str);

elseif strcmp(action,'info')
    % if java figures are in use, put info into the scrollpane, otherwise,
    % bring up the helpwindow
    if feature('javafigures')
        str = sprintf(['This demonstration shows the minimization ' ...
            'of Rosenbrock''s "banana function":\n\n'...   
            '    f(x)= 100*(x(2)-x(1)^2)^2+(1-x(1))^2\n\n'... 
            'It is called the banana function because of '...       
            'the way the curvature bends around the '...            
            'origin. It is notorious in optimization examples '... 
            'because of the slow convergence which '...             
            'most methods exhibit when trying to solve '...         
            'this problem.\n\n'...  
            'This function has a unique minimum at the '...         
            'point x=[1, 1] where f(x)=0. We show here '...         
            'a number of techniques for its minimization '...  
            'starting at the point x=[-1.9, 2]. '...  
         ]);
        cla reset;
        axis off;
        plotbanana;
        txtHndl=get(gcf,'UserData');
        set(txtHndl,'String',str);   

        % We want the edit control to be scrolled to the top. Since there is
        % currently no supported way to do this, we've put the following code 
        % in a try/catch. (If there is a failure in the try block, the text 
        % will be scrolled to the bottom.)

        try
            drawnow;
            % Get to the java component for the edit box
            % (This code presumes that there is only one scroll pane)
            found = false;
            jf = get(gcf, 'javaframe');
            ac = jf.getAxisComponent;

            % Find container - it may be in either the first or second layer
             cc = ac.getParent.getComponent(0);
             if ~isa(cc, 'com.mathworks.hg.peer.FigureComponentContainer')
                cc = ac.getParent.getComponent(1);
             end

            % Find the scroll pane
            for i=1:cc.getComponentCount
                if isa(cc.getComponent(i-1).getComponent(0), ...
                        'com.mathworks.hg.peer.utils.UIScrollPane')
                    s = cc.getComponent(i-1).getComponent(0);
                    found = true;
                    break;
                end
            end

            % Scroll the view to the top.
            if (found)
                e = s.getViewport.getView;
                awtinvoke(e, 'scrollRectToVisible(Ljava.awt.Rectangle;)V', ...
                    java.awt.Rectangle(0, 0, 1, 1));
            end
        catch
        end
    else
        helpwin(mfilename);
    end
end;    % if strcmp(action, ...

%-----------------------------------------------------------------
function stop = optdemOutFcn(x,optimvalues,state,userdata,varargin)
%
% Output function that plots the iterates
%
stop = false;
if strcmp(state,'iter')
  %fprintf('iter %d, action=%s\n',optimvalues.iteration,optimvalues.procedure);
  xpbanplt(x);
end
%-----------------------------------------------------------------
function out = xpbanplt(currPos,prevPos)
%XPBANPLT Plots one step of solution path. Called by optdemOutFcn.

persistent oldplot;

if nargin==1,
    try % this will give an error the first time, so put into try block
      set(oldplot,'Color',[0.6 0.6 0.6]);
    end
    if(min(size(currPos))>1)
        x1=currPos(1,:);
        y1=currPos(2,:);
        z1=100*(y1-x1.^2).^2+(1-x1).^2;
        L = length(x1);
        x2 = [x1 x1(1)];
        y2 = [y1 y1(1)];
        z2 = [z1 z1(1)];
        plot3(x1(1),y1(1),z1(1),'r.', ...
            'EraseMode','none', ...
            'MarkerSize',25);
        newplot=plot3(x2,y2,z2,'k-','EraseMode','normal', ...
            'MarkerSize',10);
        
        drawnow; % Draws current graph now
        pause(0.1);
        try
            set(oldplot,'Visible','off');
        end
        oldplot = newplot;
        out = [];
    else
        x1=currPos(1);
        y1=currPos(2);
        z1=100*(y1-x1.^2).^2+(1-x1).^2;
        plot3(x1(1),y1(1),z1(1),'r.', ...
            'EraseMode','none', ...
            'MarkerSize',25);
    end

elseif nargin==2,
    x1=prevPos(1);
    x2=currPos(1);
    y1=prevPos(2);
    y2=currPos(2);
    z1=100*(y1-x1.^2).^2+(1-x1).^2;
    z2=100*(y2-x2.^2).^2+(1-x2).^2;

    plot3([x1 x2],[y1 y2],[z1 z2],'b-', ...
        'EraseMode','none', ...
        'LineWidth',2); 
    plot3([x1 x2],[y1 y2],[z1 z2],'r.', ...
        'EraseMode','none', ...
        'MarkerSize',25);

    drawnow; % Draws current graph now 
    out = [];
end
%-----------------------------------------------------------------
function plotbanana
   cla reset;
   axis on;
   x=-2:.1:2;
   y=-2:.1:2;
   [xx,yy]=meshgrid(x,y);
   zz=(1-xx).^2+(yy-xx.^2).^2;
   % Set up the appropriate colormap
   % In this case, the colormap has been chosen to give the surf plot
   % a nice healthy banana color.
   hsv2=hsv;
   hsv3=[hsv2(11:64,:); hsv2(1:10,:)];
   % draw the surf plot
   surfHndl=surface(x,y,zz,'EdgeColor',[.8 .8 .8]);
   axis on;
   view(-10,10);
   colormap(hsv3);
   hold on;
   [c,contHndl]=contour3(x,y,zz+50,[100 500],'k');
   set(contHndl,'Color',[.8 .8 .8]);
   drawnow