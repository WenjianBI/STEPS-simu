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
* g1: Parameter g1[1] to characterize effect of genotype on secondary trait. More details are in 'Details' of help(data.simu). 
* b1: Parameter b1[1] to characterize effect of genotype on primary trait. More details are in 'Details' of help(data.simu).
* b3: Parameter b1[3] to characterize effect of secondary trait on primary trait. More details are in 'Details' of help(data.simu).
* qntl: See 'Details' of help(data.simu).
* toe_SV: Proportion of replications with p-value less than 0.05 for 10,000 replications.
* para_SV: Mean value of estimated g1[1] for 10,000 replications
* sd_SV: Standard derivation of estimated g1[1] for 10,000 replications.
* mean.se_SV: Mean value of estimated se(g1[1]) from Fisher information for 10,000 replications

This file can be reproduced based on STEPS-example.R by setting n.rep=10000, randome.seed=1 and other parameters as g0=b0=0, g1[2]=b1[2]=0.4, sd1=sd2=1, maf=0.3, sample size = 1000. 

