    # How long does it take to fire all empty threads
    library(doParallel);
   
    # how often to repeat the test
    n = 3
    Sys.time()->start;
    for (i in 1:n)
    { 
  	  cl <- makeCluster(detectCores()); 
  	  registerDoParallel(cl);
  	  getDoParWorkers(); 
  	  stopCluster(cl); 
  	  
    } 
    cl;
    t=(Sys.time()-start);
    cat(as.numeric(t/n)," sec total\n")
    cat(as.numeric(t/n/32),"sec. per thread\n")	
    # END
    
