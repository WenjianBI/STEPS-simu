# STEPS-simu
Examples to illustrate how to apply STEPS package. The sub-function and an example can be seen in STEPS-example.R and the example results can be seen in out-steps.continous.csv and out-steps-binary.csv.

### STEPS-example.R
An R file including codes to
* install STEPS package
* read in a sub-function for simulations given n.rep (number of replications) and random.seed
* set working direcotry
* output results with given parameter settings for both continuous and binary secondary traits

### out-steps-continuous.csv
The CSV file correponding to results of the example simulation in "STEPS-example.R" given continuous secodnary trait.

### out-steps-binary.csv
The CSV file correponding to results of the example simulation in "STEPS-example.R" given binary secodnary trait.

### tables-0.05.csv
The CSV file summerizing STEPS method in Figures 1 and 2 of Bi et al., 2018 with 10,000 replications. This file includes the following columns.
* st: "b" for "binary" and "c" for continuous
* g1: $\gamma_1$
* b1: beta1
* b3: beta3
* qntl: 
* toe_SV
* para_SV
* sd_SV
* mean.se_SV


