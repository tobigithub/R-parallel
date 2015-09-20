
### Create doSNOW cluster with 63 nodes and plot Gantt chart
### Each rscript client require 44 Mb memory, hence 4 GByte RAM needed.
### Example code from doSNOW package
### Tobias Kind (2015)

# Installation of the doSNOW parallel library with all dependencies
# uncomment next two lines if doSNOW is not installed (remove ##)
##chooseCRANmirror()
##install.packages("doSNOW", dependencies = c("Depends", "Imports")) 

# load doSnow library
library(doSNOW)

# create a sockte cluster with 64 nodes (current max=128)
# See R source connection.c which defines max number of nodes
# define NCONNECTIONS 128 /* snow needs one per slave node */
cl <- makeCluster(64,type="SOCK")

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
