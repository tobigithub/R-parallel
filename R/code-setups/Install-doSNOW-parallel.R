### Installation of the doSNOW parallel library with all dependencies
chooseCRANmirror()
install.packages("doSNOW", dependencies = c("Depends", "Imports")) 

##Loading required package: foreach
##foreach: simple, scalable parallel programming from Revolution Analytics
##Use Revolution R for scalability, fault tolerance and more.
##http://www.revolutionanalytics.com
##Loading required package: iterators
##Loading required package: snow

# Cluster
# load doSnow library
library(doSNOW)

# Create compute cluster of 4 (try 64)
# One can increase up to 128 nodes
# Each node requires 44 Mbyte RAM under WINDOWS.
cluster = makeCluster(4, type = "SOCK")

# register the cluster
registerDoSNOW(cluster)

# insert parallel computation here

# stop cluster and remove clients
stopCluster(cluster)

# insert serial backend, otherwise error in repetetive tasks
registerDoSEQ()


