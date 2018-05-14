
haploSim=function(nSNP=50,     # number of SNPs
                  rho=0.1,     # the parameter in CS(rho) for the latent multivariate Gaussian variable to be discretized to SNPs; rho=0 means all SNPs are independent;
                  nSub=1000,
                  MAF0=0,      # MAFs for the SNPs from Unif(MAF0, MAF1)
                  MAF1=0.1)
{
  R=matrix(1, nrow=nSNP, ncol=nSNP)
  for(i in 1:nSNP){
    for(j in 1:nSNP){
      if (i!=j) R[i, j]=rho
    }
  }
  svd.R=svd(R)
  R1=svd.R$u %*% diag(sqrt(svd.R$d))
  
  MAF=runif(nSNP, MAF0, MAF1)
  cutoff=qnorm(MAF)
  
  X1=matrix(rnorm(nSNP*nSub),nSNP,nSub) #: X1 ~ MVN(0, I)
  Y1=R1 %*% X1                          #: Y1 ~ MVN(0, R)
  H1=apply(Y1,2,FUN = function(x){ifelse(x<cutoff, 1, 0)})          # haplotype 1
  H1=t(H1)   # re-format the matrix so that each row for one subject and each column for one SNP
  
  X2=matrix(rnorm(nSNP*nSub),nSNP,nSub) #: X2 ~ MVN(0, I)
  Y2=R1 %*% X2                          #: Y2 ~ MVN(0, R)
  H2=apply(Y2,2,FUN = function(x){ifelse(x<cutoff, 1, 0)})          # haplotype 1
  H2=t(H2)   # re-format the matrix so that each row for one subject and each column for one SNP
  
  Geno=H1+H2;
  return(Geno)
}

# the difference between v5 and the original version is that we use another SNP in LD region of causal SNP
data.simu.poly.v6=function(nSNP=100,
                           rho.h=c(0,0.3,0.6,0.9),
                           nSubj,
                           nSamp,
                           MAF0,
                           MAF1,
                           beta1,
                           beta2,
                           beta3,
                           gamma1,
                           gamma2,
                           st="c"){        # "c" or "b"
  nh=length(rho.h)
  nSNP1=nSNP/nh    # number of SNPs in each LD scenario
  G.all=c()
  G.test=c()
  G.test1=c()
  for(i in rho.h){
    Geno=haploSim(nSNP1,i,nSubj,MAF0,MAF1)
    G.all=cbind(G.all,Geno)
    G.test=cbind(G.test,Geno[,1])
    G.test1=cbind(G.test1,Geno[,2])
  }
  
  X=rnorm(nSubj)
  e1=rnorm(nSubj)
  e2=rnorm(nSubj)
  
  Z=c(G.test%*%rep(gamma1,nh))+gamma2*X+e1          # secondary trait
  if(st=="b") Z=as.numeric(Z>median(Z))
  Y=c(G.all%*%rep(beta1,nSNP))+beta2*X+beta3*Z+e2   # primary trait
  Data.Subj=cbind(Y,Z,X,G.all)
  return(Data.Subj)
}

set.seed(1)
data1=data.simu.poly.v6(nSNP=100,
                  rho.h=c(0,0.3,0.6,0.9),
                  nSubj=6125,
                  MAF0=0.05,
                  MAF1=0.5,
                  beta1=0.1,
                  beta2=0.1,
                  beta3=0.1,
                  gamma1=0.1,
                  gamma2=0.1,
                  st="c")

colnames(data1)[3:103]=c("Age",paste0("SNP",1:100))
data1=cbind(data1[,c("Y","Z","Age")],Gender=rbinom(nrow(data1),1,0.5),data1[,paste0("SNP",1:100)])
data1[,"Age"]=(data1[,"Age"]+6)*10
qntls=quantile(data1[,"Y"],c(0.01,0.07,0.85,0.95))
data1=data1[(data1[,"Y"]<=qntls[2]&data1[,"Y"]>=qntls[1]*0.999)|(data1[,"Y"]<=qntls[4]&data1[,"Y"]>=qntls[3]),]
dim(data1)

setwd("Y:/SV-evs/final-package/real-data-simu")
write.csv(data1,"real-data-simu.csv",row.names = F)
