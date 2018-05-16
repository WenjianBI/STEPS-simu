
# please install pacakge STEPS first following 
library(devtools)   # author version: 1.13.5
install_github("WenjianBi/STEPS")

# real.data.simu has been loaded into R when installing the STEPS package
# More information about real.data.simu can be seen in https://github.com/WenjianBI/STEPS-simu/blob/master/real-data-simu/real-data-simu.csv

SNPs=grep("SNP",colnames(real.data.simu),value = T)

Range=range(real.data.simu$Y)

out.steps=c()
for(i in SNPs){
  G=real.data.simu[,i]
  data.mat=with(real.data.simu,cbind(Y,Z,G,Age,Gender))
  res.tmp=STEPS.snp(data.mat, sec.type="continuous",y0 = Range[1],y3 = Range[2]) 
  if(class(res.tmp)=="try-error"){
    out.steps=rbind(out.steps,rep(NA,3));
  }else{
    out.steps=rbind(out.steps,
                    c(res.tmp$pval,res.tmp$fnl.para$res.opt$par[2],res.tmp$inv.fsh[2,2]));
  }
}
out.steps=as.data.frame(out.steps)
out.steps=cbind(SNPs,out.steps)
colnames(out.steps)=c("SNP","pval","est-par","est-var")

head(out.steps)
# Output results can be seen in https://github.com/WenjianBI/STEPS-simu/blob/master/real-data-simu/real-data-out.csv
