### Benchmark creation of doSNOW cluster 
### Each rscript client require 44 Mb memory, hence 1-2 GByte RAM needed.
### Tobias Kind (2015)
### ---------------------------------------------------------------

# Installation of the doSNOW parallel library with all dependencies
doInstall <- TRUE # Change to FALSE if you don't want packages installed.
toInstall <- c("doSNOW") 
if((doInstall) && (!is.element(toInstall, installed.packages()[,1])))
{
	cat("Please install required package. Select server:"); chooseCRANmirror();
	install.packages(toInstall, dependencies = c("Depends", "Imports")) 
}

# load doSnow library
library(doSNOW)

# Start timer
Sys.time()->start;
{ 
	# max connections = 128
	cl <- makeCluster(32,type="SOCK")
	# do nothing inbetween (parallel code is usually here)
	# stop the cluster
	stopCluster(cl)
} 
    t=(Sys.time()-start);
    cat(round(as.numeric(t),2)," sec. total\n")
    cat(round(as.numeric(t/32),2),"sec. per thread\n")  

# clean up memory
invisible(gc())

### END
