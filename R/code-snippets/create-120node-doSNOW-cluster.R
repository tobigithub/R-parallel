### Create doSNOW cluster with 120 nodes and plot Gantt chart
### This works even on a single CPU computer
### Each rscript client requires 44 Mb memory, hence 6 GByte RAM needed.
### Example code from doSNOW package
### Tobias Kind (2015)

# Installation of the doSNOW parallel library with all dependencies
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

# create a sockte cluster with 120 nodes (current max=128)
# See R source connection.c which defines max number of nodes
# define NCONNECTIONS 128 /* snow needs one per slave node */
cl <- makeCluster(120,type="SOCK")

# calculate some data points see plot(x)
x <- rnorm(1000000)

# time the snow cluster and plot Gantt chart (documentation)
tm <- snow.time(clusterCall(cl, function(x) for (i in 1:100) sum(x), x))

# print the node timings
print(tm)

#plot the  Gantt chart
plot(tm)

# stop the cluster
stopCluster(cl)

# remove the large x object and clean up memory
remove(x); gc()

### END
