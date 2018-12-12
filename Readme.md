# DE4 Optimisation Final Coursework 

## Blender optimisation

We examined how to optimise a blender to be comfortable to use and powerful. For this casing and blades were individually optimised first.

### Subsystem 1: Casing

![Casing segment CAD model](/imgs/casing_cad.png)

#### How to run
 - Download 'rsquare.m' from Matlab File Exchange [here](https://uk.mathworks.com/matlabcentral/fileexchange/34492-r-square-the-coefficient-of-determination)
 - Ensure metamodel data - 'data.csv' or 'data2.csv' is available
 - Before using any other scripts run 'model.m' to create meta model
 - Run other scripts
   - Perform optimisation - 'casing_main.m'
   - Paramatrised optimisation - 'casing_parametrized_main.m'
   - Multiobjective optimisation - 'multiobj.m'
   - FONC evaluation - 'fonc.m'

### Subsysystem 2: Blades

### System : Blender
#### How to run
 - Ensure 'model.m' has been run beforehand and the generated variable 'beta_coeff' is in the workspace
 - Run 'time.m' to fit model to Temperature vs time data
 - Run 'AIO.m' to perform All in one optimisation of the system

