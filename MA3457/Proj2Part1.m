%Project 2 Part 1 Question 1 MATLAB Script

%Initialize Vars
temp=[-20 -15 -10 -5 -3 -2.2 -1.6 -1.3 -1.1 -1 10 20 35 50 65 80];
dc=[4.9 5.5 6.1 12.3 22 30 42 46 48.9 49.2 48.9 48.2 46.9 45.5 43.6 41.7];


%store approximations
a1 = Lin_LS(temp,dc);
a2 = Quad_LS(temp,dc);
a3 = Cubic_LS(temp,dc);
[a4,s4,mu4] = polyfit(temp,dc,4);
[a5,s5,mu5] = polyfit(temp,dc,5);
[a6,s6,mu6] = polyfit(temp,dc,6);

% Initialize arrays to store fits and goodness-of-fit.
fitresult = cell( 6, 1 );
gof = struct( 'sse', cell( 6, 1 ), ...
    'rsquare', [], 'dfe', [], 'adjrsquare', [], 'rmse', [] );

%% Fit: 'Linear Approximation'.
[xData, yData] = prepareCurveData( temp, dc );

% Set up fittype and options.
ft = fittype( 'poly1' );

% Fit model to data.
[fitresult{1}, gof(1)] = fit( xData, yData, ft );

%% Fit: 'Quadratic Approximation'.
[xData, yData] = prepareCurveData( temp, dc );

% Set up fittype and options.
ft = fittype( 'poly2' );

% Fit model to data.
[fitresult{2}, gof(2)] = fit( xData, yData, ft );

%% Fit: 'Cubic Approximation'.
[xData, yData] = prepareCurveData( temp, dc );

% Set up fittype and options.
ft = fittype( 'poly3' );

% Fit model to data.
[fitresult{3}, gof(3)] = fit( xData, yData, ft );

%% Fit: '4th Approximation'.
[xData, yData] = prepareCurveData( temp, dc );

% Set up fittype and options.
ft = fittype( 'poly4' );

% Fit model to data.
[fitresult{4}, gof(4)] = fit( xData, yData, ft );

%% Fit: '5th Approximation'.
[xData, yData] = prepareCurveData( temp, dc );

% Set up fittype and options.
ft = fittype( 'poly5' );

% Fit model to data.
[fitresult{5}, gof(5)] = fit( xData, yData, ft );


%% Fit: '6th Approximation'.
[xData, yData] = prepareCurveData( temp, dc );

% Set up fittype and options.
ft = fittype( 'poly6' );

% Fit model to data.
[fitresult{6}, gof(6)] = fit( xData, yData, ft );



plot(fitresult(1),xData,yData);
hold on
plot(fitresult(2),'b');
hold on
plot (fitresult(3),'g');
hold on
plot(fitresult(4),'m');
hold on
plot (fitresult(5),'y');
hold on
plot (fitresult(6),'k');
hold off
legend('Linear','Quadratic','Cubic','4th','5th','6th');
xlabel('Temp in Celcius');
ylabel('Dielectric Constant');