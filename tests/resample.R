library(pomp2)
library(magrittr)
set.seed(807969746L)

w <- runif(100)
k <- systematic_resample(w)
try(k <-systematic_resample(-w))
