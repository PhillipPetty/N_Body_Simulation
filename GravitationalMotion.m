% I use 'unit' to measure distance on the plot. Ex: The vector, (0,20), is
% 20 units long.
% I use 'cycle' to measure time during execution of the while loop. Ex: The
% time for execution of time = 0 to time = 50 is 50 cycles.
% All other variables are in the SI unit system.

particlePosition = [0 0; 50 0];       %in units
particleVelocity = [0 0; 0 0.0651];   %in units/cycle
particleMass = [1.989e30 5.97e24];    %in kg
G = 6.672e-11;                        %in m^3/(kg*s^2)
time = 0;                             %in cycles
distanceScale = 2.992e9;              %m/unit equating 1 AU to 50 units
timeScale = 1.585e-4;                 %cycles/s equating 1 year to 5000 cycles
positionPlot = figure;
velocityPlot = figure;
xVelocity = [1:5000; zeros(1,5000)];
yVelocity = [1:5000; zeros(1,5000)];

while time < 5000
    figure(positionPlot);
    plot(particlePosition(:,1),particlePosition(:,2),'ok')
    xlim([-75,75]);
    ylim([-75,75]);
    
    y = particlePosition(4)-particlePosition(3);
    x = particlePosition(2)-particlePosition(1);
    acceleration = G*particleMass(1)/(((pdist(particlePosition,'euclidean')*distanceScale*timeScale)^2)*distanceScale); 
    theta = atan2d(y,x);
    yAccel = acceleration*sind(theta);
    xAccel = acceleration*cosd(theta);
   
    particleVelocity(2) = particleVelocity(2) - xAccel;         %Treating each cycle as one second, but timescale is different (causing error)
    particleVelocity(4) = particleVelocity(4) - yAccel;
    
    particlePosition = particlePosition + particleVelocity;
    xVelocity(2,time+1) = particleVelocity(2);
    yVelocity(2,time+1) = particleVelocity(4);
    time = time + 1;
    drawnow;
end

figure(velocityPlot);

    plot(xVelocity(1,:),xVelocity(2,:),'-b',yVelocity(1,:),yVelocity(2,:),'.-y')


