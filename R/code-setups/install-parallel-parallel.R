# Library parallel() is a native R library, no CRAN required
library(parallel)

# detect true cores requires parallel()
nCores <- detectCores(logical = FALSE)
# detect threads
nThreads <- detectCores(logical = TRUE)
# detect threads
cat("CPU with",nCores,"cores and",nThreads,"threads detected.\n")

# automatically creates socketCluster under WIN, fork not allowed
# maximum number of cluster nodes is 128
cl <- makeCluster(nThreads); cl;
# insert parallel calculations here
# stop the cluster and remove parallel instances
stopCluster(cl)

# END
