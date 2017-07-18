% I use 'unit' to measure distance on the plot. Ex: The vector, (0,20), is
% 20 units long.
% I use 'cycle' to measure time during execution of the while loop. Ex: The
% time for execution of time = 0 to time = 50 is 50 cycles.
% All other variables are in the SI unit system.

bodyPosition = [15.4 0 0; 35.9 0 0; 50.0 0 0; 69.1 0 0; 247 0 0; 452 0 0; 916 0 0; 1485 0 0; 0 0 0];                           %in 'units'. Position of Sol in last row.
bodyVelocity = [0 0.124 0; 0 0.074 0; 0 0.0639 0; 0 0.056 0; 0 0.029 0; 0 0.021 0; 0 0.015 0; 0 0.012 0; 0 0 0];               %in 'units/cycle'. Velocity of Sol in last row.
particleMass = [.33011e24 4.87e24 5.97e24 0.642e24 1898e24 568e24 86.8e24 102e24 1.989e30];                                    %in kg
G = 6.672e-11;                                        %in m^3/(kg*s^2)
time = 0;                                             %in cycles
distanceScale = 2.992e9;                              %m/unit equating 1 AU to 50 units
timeScale = 1.585e-4;                                 %cycles/s equating 1 year to 5000 cycles
positionPlot = figure;
% velocityPlot = figure;
xVelocity = [1:5000; zeros(8,5000)];
yVelocity = [1:5000; zeros(8,5000)];

while time < 1000
    figure(positionPlot);
    set(positionPlot, 'Position', [0 10 1500 1000])
    plot(bodyPosition(:,1),bodyPosition(:,2),'ok')
    xlim([-75,75]);
    ylim([-75,75]);
    distBetweenBodies = squareform(pdist(bodyPosition))*distanceScale*timeScale;
    
    for planetFromSun = 1:8
       yAccelTot = 0;
       xAccelTot = 0;
        
       for body = 1:9
          if planetFromSun ~= body
               y = bodyPosition(body,2)-bodyPosition(planetFromSun,2);
               x = bodyPosition(body,1)-bodyPosition(planetFromSun,1);
               acceleration = G*particleMass(body)/(((distBetweenBodies(planetFromSun,body))^2)*distanceScale); 
               theta = atan2d(y,x);
               yAccel = acceleration*sind(theta);
               xAccel = acceleration*cosd(theta);
               
               yAccelTot = yAccelTot + yAccel;
               xAccelTot = xAccelTot + xAccel;
          end
       end
        bodyVelocity(planetFromSun,1) = bodyVelocity(planetFromSun,1) + xAccelTot;
        bodyVelocity(planetFromSun,2) = bodyVelocity(planetFromSun,2) + yAccelTot;
    end
    
    bodyPosition = bodyPosition + bodyVelocity;
%     xVelocity(2,time+1) = bodyVelocity(2);
%     yVelocity(2,time+1) = bodyVelocity(4);
    time = time + 1;
    drawnow;
end

% figure(velocityPlot);
% 
%     plot(xVelocity(1,:),xVelocity(2,:),'-b',yVelocity(1,:),yVelocity(2,:),'.-y')


