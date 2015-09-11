### ***********************************************************************
### Profiling peak finding times for xcms v3.1 (no final results)
### The scripts times centwave and massifquant with different options for QTOF,
### or Orbitraps and provides individual timings for each
### URL: http://metlin.scripps.edu/download/
### LC/MS and GC/MS Data Analysis and Alignement from netCDF data
### Author: Colin A. Smith <csmith@scripps.edu>
### ***********************************************************************

### ***********************************************************************
### The script assumes xcms is installed via Packages->Install->BioConducor
###     install.packages("xcms")
###	install.packages("snow")
###     source("http://bioconductor.org/biocLite.R")
###     biocLite()
###     biocLite("multtest")
###	biocLite("faahKO")
###     biocLite("msdata")
### Copy this file into commandline or open via "Open script" 
### Set 5 variables in +++ section and run have fun
### Example TimingScript: Tobias Kind fiehnlab.ucdavis.edu 2015
### ***********************************************************************

### +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
### These are the 5 variables you have to set for your own datafiles anything else runs automatically
### Set your working directory under Windows, where your netCDF, mzXML files are stored
### Organize samples in subdirectories according to their class names WT/GM, Sick/Healthy etc.
### Important: use "/" not "\" 
myDir = "Z:/faahKO/inst/cdf/"
myClass1 = "KO"
myClass2 = "WT"
myResultDir = "myAlign"
myCPUs = 16
### +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

    
TimeMeSec <- function(x) {
	t1 <- Sys.time()
	#evaluate function
	x
	t2 <-Sys.time()
	# return Seconds
	as.numeric(t2-t1,units = "secs")
}    
    
    ### Start timer for global function
    GlobalTimeStart <-Sys.time()	
    
    ### Garbage Collection
    gc()
    
    ### change working directory to your files, see +++ section
    setwd(myDir)
    
    ### get working directory
    (WD <- getwd())
    
    ### load the xcms package
    library(xcms)
    
    ### when using snow under Windows, RMPI must be removed
    library (snow)
    
    ### ---- start of peak finding timings

    ### finds peaks in NetCDF, use number of slaves to distribute
    xcmsFindPeaksTime = TimeMeSec(xset <- xcmsSet(nSlaves=myCPUs))
    xset
    rm(xset)
    
    ### HP_QTOF  30ppm (metabonexus) Metabolomics; December 2014, Volume 10, Issue 6, pp 1084-1093
    HP_QTOF_xcmsFindPeaksTime = TimeMeSec(xset <- xcmsSet(nSlaves=myCPUs,method="centWave",ppm=30,peakwidth=c(10,60),prefilter=c(3,1000),snthresh=10,integrate=1,noise=200))
    xset
    rm(xset)
    
    ### HP_QTOF_high 15ppm  (metabonexus)
    HP_QTOFHigh_xcmsFindPeaksTime = TimeMeSec(xset <- xcmsSet(nSlaves=myCPUs,method="centWave",ppm=15,peakwidth=c(10,60),prefilter=c(3,1000),snthresh=10,integrate=1,noise=200))
    xset
    rm(xset)
    
    ###	"HP_Orbi" 2.5 ppm (metabonexus)
    HP_Orbi_xcmsFindPeaksTime = TimeMeSec(xset <- xcmsSet(nSlaves=myCPUs,method="centWave",ppm=2.5,peakwidth=c(10,60),prefilter=c(3,5000),snthresh=10,integrate=1,noise=200))
    xset
    rm(xset)
    
    ###	 "UP_QTOF" 30 ppm (metabonexus)
    UP_QTOF_xcmsFindPeaksTime = TimeMeSec(xset <- xcmsSet(nSlaves=myCPUs,method="centWave",ppm=30,peakwidth=c(5,20),prefilter=c(3,1000),snthresh=10,integrate=1,noise=200))
    xset
    rm(xset)
    
    ###  "UP_QTOF_high" 15 ppm (metabonexus)
    UP_QTOF_high_xcmsFindPeaksTime = TimeMeSec(xset <- xcmsSet(nSlaves=myCPUs,method="centWave",ppm=15,peakwidth=c(5,20),prefilter=c(3,1000),snthresh=10,integrate=1,noise=200))
    xset
    rm(xset)
    
    ###  "UP_Orbi" 2.5 ppm (metabonexus)
    UP_Orbi_xcmsFindPeaksTime = TimeMeSec(xset <- xcmsSet(nSlaves=myCPUs,method="centWave",ppm=2.5,peakwidth=c(5,20),prefilter=c(3,5000),snthresh=10,integrate=1,noise=200))
    xset
    rm(xset)
   
    ### "mzMatch" Bioinformatics. 2013 Jan 15; 29(2): 281–283.
    mzMatch_xcmsFindPeaksTime = TimeMeSec(xset <- xcmsSet(nSlaves=myCPUs, method="centWave",ppm=2, peakwidth=c(10,100), snthresh=5, prefilter=c(3,1000), integrate=1, mzdiff=0.01, verbose.columns=TRUE,fitgauss=FALSE))
    xset
    rm(xset)
    
    ### "Patti" Nat Protoc. 2012 Feb 16; 7(3): 508–516. 
    CentWaveGen_xcmsFindPeaksTime =   TimeMeSec(xset <- xcmsSet(nSlaves=myCPUs,method="centWave",ppm=30,peakwidth=c(10,60),prefilter=c(0,0)))
    xset
    rm(xset)
 
    ### Christopher Conley 
    massifquant_xcmsFindPeaksTime = TimeMeSec(xset <- xcmsSet(nSlaves=myCPUs,method="massifquant",consecMissedLimit=1,snthresh=10,criticalValue=1.73, ppm = 10, peakwidth= c(30, 60), prefilter= c(1,3000), withWave = 0))
    xset
    rm(xset)
 
    ### "Can we trust metabolomics"
    TrustMetabolomics_xcmsFindPeaksTime = TimeMeSec(xset <- xcmsSet(nSlaves=myCPUs,method="centWave", peakwidth=c(3,15), snthresh=5))
    xset
    rm(xset)

    
    ### IPO centwave initial
    IPOCentwave_xcmsFindPeaksTime = TimeMeSec(xset <- xcmsSet(nSlaves=myCPUs,method="centWave", peakwidth=c(20,50), 
    						ppm=c(17,32), mzdiff=c(-0.001, 0.01), snthresh=10, noise=0, prefilter=3,
    						mzCenterFun="wMean", integrate=1, fitgauss=FALSE, verbose.columns=FALSE)) 
    xset
    rm(xset)       
    
    ### IPO matchedFilter for lowres data
    IPOMatchedFilter_xcmsFindPeaksTime = TimeMeSec(xset <- xcmsSet(nSlaves=myCPUs,method="matchedFilter",fwhm=c(25), snthresh=c(3), step=c(0.05), steps=c(2),max=5, mzdiff=0.8))
    xset
    rm(xset)
    
    ### ---- end of peak finding timings
    
    GlobalTimeStop <-Sys.time()	
    GlobalTime = as.numeric(GlobalTimeStop-GlobalTimeStart,units = "secs")
    
    ### Original XCMS with faahKO set
    cat("xcmsFindPeaksTime original: ",xcmsFindPeaksTime,"[s]\n");

    ### HP_QTOF from metabonexus 30ppm
    cat("HP_QTOF 30 ppm: ", HP_QTOF_xcmsFindPeaksTime,"[s]\n");
 
    ### HP_QTOF_high from metabonexus 15ppm
    cat("HP_QTOF_high 15 ppm: ", HP_QTOFHigh_xcmsFindPeaksTime,"[s]\n"); 

    ###	"HP_Orbi" 2.5 ppm
    cat("HP_Orbi 2.5 ppm : ", HP_Orbi_xcmsFindPeaksTime,"[s]\n"); 

    ###	 "UP_QTOF" 30 ppm
    cat("UP_QTOF 30 ppm : ",UP_QTOF_xcmsFindPeaksTime,"[s]\n"); 

    ###  "UP_QTOF_high" 15 ppm
    cat("UP_QTOF_high 15 ppm : ", UP_QTOF_high_xcmsFindPeaksTime,"[s]\n"); 

    ###  "UP_Orbi" 2.5 ppm
    cat("UP_Orbi  2.5 ppm :", UP_Orbi_xcmsFindPeaksTime,"[s]\n");
     
    ### "mzMatch 2.0 ppm" 
    cat("mzMatch 2.0 ppm: ",mzMatch_xcmsFindPeaksTime,"[s]\n");

    ### "Generic 30 ppm"
    cat("CentWave Generic 30 ppm: ",CentWaveGen_xcmsFindPeaksTime,"[s]\n");
    
    ### massifquant - Christopher Conley 
    cat("massifquant 10 ppm: ",massifquant_xcmsFindPeaksTime,"[s]\n");

    ### "Can we trust metabolomics" Metabolomics August 2015, Volume 11, Issue 4, pp 807-821
    cat("Trust Metabolomics: ",TrustMetabolomics_xcmsFindPeaksTime,"[s]\n");

    ### IPO centwave initial
    cat(" IPO centwave initial :",IPOCentwave_xcmsFindPeaksTime,"[s]\n");

    ### IPO MatchedFilter initial
    cat(" IPO MatchedFilter initial :",IPOMatchedFilter_xcmsFindPeaksTime,"[s]\n");

print("Finished profiling peakfinding.") 

