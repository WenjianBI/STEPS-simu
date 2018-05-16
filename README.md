# STEPS-simu
Examples to illustrate how to apply STEPS package. The sub-function and an example can be seen in STEPS-example.R and the example results can be seen in out-steps.continous.csv and out-steps-binary.csv.

## STEPS-example.R
An R file including codes to
* install STEPS package
* read in a sub-function for simulations given n.rep (number of replications) and random.seed
* set working direcotry
* output results with given parameter settings for both continuous and binary secondary traits

## out-steps-continuous.csv
The CSV file correponding to results of the example simulation in "STEPS-example.R" given continuous secodnary trait.

## out-steps-binary.csv
The CSV file correponding to results of the example simulation in "STEPS-example.R" given binary secodnary trait.

## tables-0.05.csv
The CSV file summerizing STEPS method results in Figures 1 and 2 of Bi et al., 2018. This file includes the following columns.
* st: "b" for "binary" and "c" for continuous
* g1: Parameter g1[1] to characterize effect of genotype on secondary trait. More details are in 'Details' of help(data.simu). 
* b1: Parameter b1[1] to characterize effect of genotype on primary trait. More details are in 'Details' of help(data.simu).
* b3: Parameter b3 to characterize effect of secondary trait on primary trait. More details are in 'Details' of help(data.simu).
* qntl: See 'Details' of help(data.simu).
* toe_SV: Proportion of replications with p-value less than 0.05 for 10,000 replications.
* para_SV: Mean value of estimated g1[1] for 10,000 replications
* sd_SV: Standard derivation of estimated g1[1] for 10,000 replications.
* mean.se_SV: Mean value of estimated se(g1[1]) from Fisher information for 10,000 replications

This file can be reproduced based on STEPS-example.R by setting n.rep=10000, random.seed=1 and other parameters as g0=b0=0, g1[2]=b1[2]=0.4, sd1=sd2=1, maf=0.3, sample size = 1000. 

## real-data-simu

### real-data-simu.csv
The CSV file is a simulated dataset with 980 samples to mimic the study design of BEN GWAS data (https://www.ncbi.nlm.nih.gov/projects/gap/cgi-bin/study.cgi?study_id=phs000507.v1.p1). Here we only simulated 100 SNPs and retained samples whose primary trait is on 1-7th and 85-95th. The dataset is automatically loaded into R when installing the STEPS package. It includes the following columns:
* Y: primary trait
* Z: secondary trait
* Age: age as covariate
* Gender: gender as covariate
* SNP1-SNP100: genotype of SNPs 1-100

### real-data-analyze.R
The R code to analyze real-data-simu.csv

### real-data-out.csv
The CSV file with analysis output of STEPS method for real-data-simu.csv. The file includes four columns:
* SNP: SNP id
* pval: p-values to associate SNP with secondary trait
* est-par: estimated parameter of SNP effect on secondary trait
* est-var: estimated variance of SNP effect on secodnary trait from Fisher information matrix

