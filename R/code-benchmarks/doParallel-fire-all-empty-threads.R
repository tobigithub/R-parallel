### ---------------------------------------------------------------
### Benchmark for creation of empty doParallel cluster 
### How long does it take to fire all empty threads
### Each rscript client require 44 Mb memory, hence 1-2 GByte RAM needed.
### Tobias Kind (2015) https://github.com/tobigithub/R-parallel/
### ---------------------------------------------------------------

# Installation of the required library with all dependencies
doInstall <- TRUE # Change to FALSE if you don't want packages installed.
toInstall <- c("doParallel") 
if((doInstall) && (!is.element(toInstall, installed.packages()[,1])))
{
	cat("Please install required package. Select server:"); chooseCRANmirror();
	install.packages(toInstall, dependencies = c("Depends", "Imports")) 
}
    
library(doParallel);
   
# how often to repeat the test
n = 3
Sys.time()->start;
for (i in 1:n)
{ 
 	  cl <- makeCluster(detectCores()); 
  	  registerDoParallel(cl);
  	  #getDoParWorkers(); 
  	  stopCluster(cl); 
  	  
} 
cl;
t=(Sys.time()-start);
cat(round(as.numeric(t/n),2)," sec total\n")
cat(round(as.numeric(t/n/detectCores()),2),"sec. per thread\n")	
    
# clean up memory
invisible(gc())
    
# END
    
