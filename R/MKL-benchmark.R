### Adopted micro-benchmark to test the Revolution R engine and MKL
### Tobias Kind (2015) https://github.com/tobigithub/R-parallel/
### Set MKL threads if Revolution R Open or Revolution R Enterprise is available
### Original Source from https://gist.github.com/andrie/24c9672f1ea39af89c66

### function measures and returns time in sec
TimeMeSec <- function(x) {
	t1 <- Sys.time()
	#evaluate function
	x
	t2 <-Sys.time()
	# return Seconds
	return(as.numeric(t2-t1,units = "secs"))
}

### Set number of CPUs (not threads) for Revo Pro R MKL
SetMKL <-function(nCPU) {

	if(require("RevoUtilsMath")){
	  setMKLthreads(nCPU)}
}

### Check correctness with getMKLthreads()
GetMKL <-function() {

	if(require("RevoUtilsMath")){
	return(getMKLthreads())}
}


### function runs original MKL mikrobenchmarks
### returns multiple times in a list
RunMKL <-function() {

#### Initialization
# collect garbage
gc()
# seedlings
set.seed (1)

# Matrix creation
# writeLines("Now calculating: Matrix creation")
m <- 10000
n <-  5000
t1 = TimeMeSec (A <- matrix (runif (m*n),m,n))
cat("Matrix creation:",t1," sec. \n")

# Matrix multiply
# writeLines("Now calculating: Matrix multiply")
t2 = TimeMeSec(B <- crossprod(A))
cat("Matrix multiply:", t2," sec. \n")

# Cholesky Factorization
# writeLines("Now calculating: Cholesky Factorization")
t3 = TimeMeSec(C <- chol(B))
cat("Cholesky Factorization:",t3," sec. \n")

# Singular Value Deomposition
# writeLines("Now calculating: Singular Value Deomposition") 
m <- 10000
n <- 2000
A <- matrix (runif (m*n),m,n)
t4 = TimeMeSec(S <- svd (A,nu=0,nv=0))
cat("Singular Value Deomposition:",t4," sec. \n")

# Principal Components Analysis
# writeLines("Now calculating: Principal Components Analysis")
m <- 10000
n <- 2000
A <- matrix (runif (m*n),m,n)
t5 = TimeMeSec(P <- prcomp(A))
cat("Principal Components Analysis:",t5," sec. \n")

# Linear Discriminant Analysis
# writeLines("Now calculating: Linear Discriminant Analysis")
g <- 5
k <- round (m/2)
A <- data.frame (A, fac=sample (LETTERS[1:g],m,replace=TRUE))
train <- sample(1:m, k)
t6 = TimeMeSec(L <- lda(fac ~., data=A, prior=rep(1,g)/g, subset=train))
cat("Linear Discriminant Analysis:\t",t6," sec. \n")

# Sum of all times
t7 = t1+t2+t3+t4+t5+t6 
cat("Total: ",t7," sec. \n")

# end of function
}

####---------------####
#### Main Function ###
####---------------####

# load required libraries upfront
library('MASS')
# save original MKL threads
if(require("RevoUtilsMath")){SaveMKL = getMKLthreads()}

# requires Revolution Analytics R
# run with 16 CPUs, under original R use RunMKL() only run once
SetMKL(16); cat(GetMKL(), "MKLthreads\n");   RunMKL(); 
SetMKL(14); cat(GetMKL(), "MKLthreads\n");   RunMKL(); 
SetMKL(12); cat(GetMKL(), "MKLthreads\n");   RunMKL(); 
SetMKL(10); cat(GetMKL(), "MKLthreads\n");   RunMKL(); 
SetMKL(8);  cat(GetMKL(), "MKLthreads\n");   RunMKL(); 
SetMKL(6);  cat(GetMKL(), "MKLthreads\n");   RunMKL(); 
SetMKL(4);  cat(GetMKL(), "MKLthreads\n");   RunMKL(); 
SetMKL(1);  cat(GetMKL(), "MKLthreads\n");   RunMKL(); 

# restore original MKL threads
if(require("RevoUtilsMath")){setMKLthreads(SaveMKL)}
####------ END -----####
