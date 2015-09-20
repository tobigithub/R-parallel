### Installation of package with all dependent packages
chooseCRANmirror()
install.packages("doParallel", dependencies = c("Depends", "Imports")) 
# also installing the dependencies ‘foreach’, ‘iterators’
#package ‘foreach’ successfully unpacked and MD5 sums checked
#package ‘iterators’ successfully unpacked and MD5 sums checked
#package ‘doParallel’ successfully unpacked and MD5 sums checked
### End of installation, this needs to be run only once

# load the doParallel for direct use
library(doParallel)
# make a cluster with all possible threads (not cores)
cl <- makeCluster(detectCores())
# register the number of parallel workers (here all CPUs)
registerDoParallel(cl)
# return number of parallel workers
getDoParWorkers() 
# insert parallel calculations here
# stop the cluster and remove  Rscript.exe childs (WIN)
stopCluster(cl)
