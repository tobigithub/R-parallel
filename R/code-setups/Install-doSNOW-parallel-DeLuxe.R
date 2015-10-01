# ---------------------------------------------- 
# Deluxe doSNOW cluster setup in R 
# Tobias Kind (2015) 
# https://github.com/tobigithub/R-parallel/wiki/
# ---------------------------------------------- 

# Installation of the doSNOW parallel library with all dependencies
doInstall <- TRUE # Change to FALSE if you don't want packages installed.
toInstall <- c("doSNOW") 
if((doInstall) && (!is.element(toInstall, installed.packages()[,1])))
{
    cat("Please install required package. Select server:"); chooseCRANmirror();
    install.packages(toInstall, dependencies = c("Depends", "Imports")) 
}

# load doSnow and (parallel for CPU info) library
library(doSNOW)
library(parallel)

# For doSNOW one can increase up to 128 nodes
# Each node requires 44 Mbyte RAM under WINDOWS.

# detect cores with parallel() package
nCores <- detectCores(logical = FALSE)
cat(nCores, " cores detected.")

# detect threads with parallel()
nThreads<- detectCores(logical = TRUE)
cat(nThreads, " threads detected.")

# Create doSNOW compute cluster (try 64)
# One can increase up to 128 nodes
# Each node requires 44 Mbyte RAM under WINDOWS.
cluster = makeCluster(nThreads, type = "SOCK")
class(cluster);

# register the cluster
registerDoSNOW(cluster)

#get info
getDoParWorkers(); getDoParName();

# insert parallel computation here
        
# stop cluster and remove clients
stopCluster(cluster); print("Cluster stopped.")

# clean up a bit.
invisible(gc); remove(nCores); remove(nThreads); remove(cluster); 

# END
