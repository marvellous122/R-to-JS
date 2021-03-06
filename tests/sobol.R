png(filename="sobol-%02d.png",res=100)
library(pomp2)

## Sobol' low-discrepancy design
plot(sobolDesign(lower=c(a=0,b=100),upper=c(b=200,a=1),100))

try(sobolDesign(lower=c(a=0,b=100),upper=c(b=200,a=1,q=99),10))
try(sobolDesign(lower=c(0,100),upper=c(b=200,a=1),10))
try(sobolDesign(lower=c(a=0,b=100),upper=c(b=200,c=1),10))

try(sobolDesign(lower=c(a=0,b=100),upper=c(b=200,a=1),2^30+1))

rnames <- sprintf("n%04d",1:5000)
try(sobolDesign(lower=setNames(runif(5000),rnames),
                upper=setNames(runif(5000,min=-1,max=0),rnames),
                100))
x <- sobolDesign(lower=setNames(runif(15),head(rnames,15)),
  upper=setNames(runif(15,min=1,max=2),head(rnames,15)),
  100)

dev.off()
