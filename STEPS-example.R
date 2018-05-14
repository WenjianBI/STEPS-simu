
# IMPORTANT
# please install pacakge STEPS first following 
library(devtools)   # author version: 1.13.5
install_github("WenjianBi/STEPS")

# Function Input
# Input arguments: par.ls, sec.type, sd1, sd2, N, maf, cutoff and qntl are consistent as function STEPS::data.simu
# Input arguments: n.rep - number of replications
# Input arguments: random.seed - random seed 
STEPS.simu.example=function(par.ls,
                            sec.type, 
                            sd1=1, 
                            sd2=1, 
                            N=1000, 
                            maf=0.3,
                            cutoff=0, 
                            qntl=0.01,
                            n.rep=100,
                            random.seed=1)
{
  rand.n=random.seed
  out.steps = matrix(NA,n.rep,4,
                     dimnames = list(NULL,c("rand-number","p-value","par.est","var.est")))
  for(i in 1:n.rep){
    if(i %% 100==0) print(paste0("Complete ",i,"/",n.rep," replications."))
    set.seed(rand.n)
    data.mat = data.simu(par.ls, sec.type, sd1 = 1, sd2 = 1, N = 1000, maf = 0.3,
                         cutoff = cutoff, qntl = qntl)
    res.tmp=STEPS.snp(data.mat, sec.type)
    if(class(res.tmp)=="try-error"){
      out.steps[i,2:4]=NA;
    }else{
      out.steps[i,2:4]=c(res.tmp$pval,res.tmp$fnl.para$res.opt$par[2],res.tmp$inv.fsh[2,2])
    }
    out.steps[i,1]=rand.n
    rand.n=rand.n+1
  }
  return(out.steps)
}


setwd("Y:/SV-evs/final-package/STEPS-simu")  # please give a directory for output
## Continuous secondary trait
out.steps=STEPS.simu.example(par.ls=list(b0=0,b1=c(0.4,0.4),b3=0.7,g0=0,g1=c(0,0.4)),
                             sec.type="continuous")
write.csv(out.steps,"out-steps-continuous.csv",row.names = F)
head(out.steps)
# rand-number   p-value       par.est     var.est
# 1 0.7857463 -1.317530e-02 0.002349087
# 2 0.7508541  1.521602e-02 0.002296560
# 3 0.9987770 -7.039593e-05 0.002109362
# 4 0.7367029 -1.559320e-02 0.002150882
# 5 0.8980736  5.995110e-03 0.002190425
# 6 0.2533259 -5.217004e-02 0.002085815

## Binary secondary trait
out.steps=STEPS.simu.example(par.ls=list(b0=0,b1=c(0.4,0.4),b3=0.7,g0=0,g1=c(0,0.4)),
                             sec.type="binary")
write.csv(out.steps,"out-steps-binary.csv",row.names = F)
head(out.steps)
# rand-number   p-value     par.est     var.est
# 1 0.3186230  0.10284621 0.010634873
# 2 0.1591508  0.15623643 0.012314032
# 3 0.4558806  0.07894966 0.011210726
# 4 0.5764840  0.05957385 0.011376839
# 5 0.1779939  0.14393400 0.011418760
# 6 0.4871597 -0.06929252 0.009945152




