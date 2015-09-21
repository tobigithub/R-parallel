### Test execution times on doSNOW cluster with up to 120 nodes 
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


# Reset plotting grid
par(mfrow=c(1,1))

cl <- makeCluster(4,type="SOCK")
x <- rnorm(1000000)
tm1 <- snow.time(clusterCall(cl, function(x) for (i in 1:1000) sum(x), x))
print(tm1)
plot(tm1)
stopCluster(cl)
#-----------------------------------------------------------------------------
cl <- makeCluster(8,type="SOCK")
x <- rnorm(1000000)
tm2 <- snow.time(clusterCall(cl, function(x) for (i in 1:1000) sum(x), x))
print(tm2)
plot(tm2)
stopCluster(cl)
#-----------------------------------------------------------------------------
cl <- makeCluster(16,type="SOCK")
x <- rnorm(1000000)
tm3 <- snow.time(clusterCall(cl, function(x) for (i in 1:1000) sum(x), x))
print(tm3)
plot(tm3)
stopCluster(cl)
#-----------------------------------------------------------------------------
cl <- makeCluster(32,type="SOCK")
x <- rnorm(1000000)
tm4 <- snow.time(clusterCall(cl, function(x) for (i in 1:1000) sum(x), x))
print(tm4)
plot(tm4)
stopCluster(cl)
#------------------------------------------------------------------------------
cl <- makeCluster(64,type="SOCK")
x <- rnorm(1000000)
tm5 <- snow.time(clusterCall(cl, function(x) for (i in 1:1000) sum(x), x))
print(tm5)
plot(tm5)
stopCluster(cl)
#------------------------------------------------------------------------------
cl <- makeCluster(120,type="SOCK")
x <- rnorm(1000000)
tm6 <- snow.time(clusterCall(cl, function(x) for (i in 1:1000) sum(x), x))
print(tm6)
plot(tm6)
stopCluster(cl)
#------------------------------------------------------------------------------
# set plot region to 2 down and 3 left
par(mfrow=c(2,3))
plot(tm1)
plot(tm2)
plot(tm3)
plot(tm4)
plot(tm5)
plot(tm6)

# clean up memory
invisible(gc())

# END
