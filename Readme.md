# DE4 Optimisation Final Coursework 

## Blender optimisation

We examined how to optimise a blender to be comfortable to use and powerful. For this casing and blades were individually optimised first.

### Subsystem 1: Casing, Karolina Jankiewicz

![Casing segment CAD model](/imgs/casing_cad.png)

#### How to run
 - Download 'rsquare.m' from Matlab File Exchange [here](https://uk.mathworks.com/matlabcentral/fileexchange/34492-r-square-the-coefficient-of-determination) and place it in the 'Subsystem1' directory
 - Ensure metamodel data - 'data.csv' or 'data2.csv' is available
 - Before using any other scripts run 'model.m' to create meta model
 - Run other scripts
   - Perform optimisation - 'casing_main.m'
   - Paramatrised optimisation - 'casing_parametrized_main.m'
   - Multiobjective optimisation - 'multiobj.m'
   - Parametric study - 'sens.m'
   - FONC evaluation - 'fonc.m'

### Subsystem 2: Blades, Tessa Smulders

Subsystem 2 looks at optimizing the blades for the least amount of time taken per rotation. The optimization studies were done using the three algorithms in fmincon and the global search. 

The genetic algorithm multi-objective solver was then used to find an optimum for the lightest and fastest blade. 

![Blade Simplified Model](/imgs/BladeModel.png)

#### How to run
Run the following files, make sure the parameters clear between each run:
- fmincon - "fminconBlades.m"
- global search - "globalsearch.m"
- multi-objective genetic algorithm - "multiObjBlades.m"

note: the genetic algorithm will give different results each time it runs, meaning it will not match the values given in the report

#### Materials
The material density was taken to be a continuous function. When a value is found, then the closest material is chosen from the list based on values found in CES Edupack. 

![Food safe metals and their densities](/imgs/MaterialListBlades.png)

### System : Blender

We are optimizing the blender for comfort and have used the All in One method to do so. 

#### How to run
 - Ensure 'model.m' has been run beforehand and the generated variable 'beta_coeff' is in the workspace
 - Run 'time.m' to fit model to Temperature vs time data
 - Run 'AIO.m' to perform All in one optimisation of the system
 - Run 'AIO_p.m' to perform All in one optimisation of the system with fixed casing material
