### Benchmark creation of doSNOW cluster 
### Each rscript client require 44 Mb memory, hence 1-2 GByte RAM needed.
### Tobias Kind (2015)

# Installation of the doSNOW parallel library with all dependencies
# uncomment next two lines if doSNOW is not installed (remove ##)
##chooseCRANmirror()
##install.packages("doSNOW", dependencies = c("Depends", "Imports")) 

# load doSnow library
library(doSNOW)

# Start timer
Sys.time()->start;
{ 
	# max connections = 128
	cl <- makeCluster(32,type="SOCK")

	# stop the cluster
	stopCluster(cl)
} 
    t=(Sys.time()-start);
    cat(as.numeric(t)," sec. total\n")
    cat(as.numeric(t/32),"sec. per thread\n")  

# clean up memory
gc()

### END
