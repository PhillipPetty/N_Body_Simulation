function [ force ] = gravitationalForce( mass1, mass2, radius )
%Calculates the gravitational force between two objects
%   

G = 6.672e-11;

force = (G*mass1*mass2)/(radius^2);

end

