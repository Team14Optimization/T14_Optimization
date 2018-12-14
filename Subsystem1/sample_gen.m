%Generate samples for simulation using Latin Hypercube Sampling
N=50; %number of samples
design=lhsdesign(N,6,'iterations',20,'criterion','maximin')

%Minimum and maximum values of variables:
%Radius of motor, Air gap thickness, Casing thicknes, Density, Condctivity,
%Specific Heat capacity
mins=[0.03, 0.001, 0.001, 890, 0.117, 1386];
maxs=[0.035, 0.006, 0.006, 1310,0.461, 1881];
dif=maxs-mins;
Samples=dif.*design+mins; %COnvert LHS given values to variable values