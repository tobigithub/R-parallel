### ***********************************************************************
### Profiling times for xcms v3.1
### The scripts times xcmsSet(), group(), retcor(),fillPeaks() and reporttab()
### and provides individual timings for each
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
    
    ### you can get help typing the following command at the commandline
    # ?retcor
    
    ### finds peaks in NetCDF, use number of slaves to distribute
    xcmsFindPeaksTime = TimeMeSec(xset <- xcmsSet(nSlaves=myCPUs))
    
    ### print used files and memory usuage
    xset
    
    ###  Group peaks together across samples and show fancy graphics 
    ###  you can remove the sleep timer (silent run) or set it to 0.001 or slow to show(1.0)
    xcmsGroupTime = TimeMeSec(xset <- group(xset,sleep=.0001))
 
    ### calculate retention time deviations for every time 
    xcmsRetCorTime = TimeMeSec(xset2 <- retcor(xset, family="s", plottype="m"))
     
    ###  Group peaks together across samples, set bandwitdh, change important m/z parameters here
    ###  Syntax: group(object, bw = 30, minfrac = 0.5, minsamp= 1,  mzwid = 0.25, max = 5, sleep = 0) 
    xcmsGroupSamplesTime = TimeMeSec(xset2 <- group(xset2, bw =10))
      
    ###   identify peak groups and integrate samples
    xcmsRetFillPeakTime = TimeMeSec(xset3 <- fillPeaks(xset2))
    
    ###  print statistics
    xset3
    
    ### ask  par(ask=T) or dont ask  par(ask=F) for confirmation
    par(ask=F)
    
    ### create report and save the result in EXCEL file, print 30 important peaks as PNG 
    xcmsReportTime = TimeMeSec(reporttab <- diffreport(xset3, myClass1, myClass2, myResultDir, 30, metlin = 0.15))
    
    ### print file names
    # dir(path = ".", pattern = NULL, all.files = FALSE, full.names = FALSE, recursive = FALSE)
    
    ### output were done!
    print("Finished, open by yourself the file myAlign.tsv and pictures in myAlign_eic") 

    GlobalTimeStop <-Sys.time()	
    GlobalTime = as.numeric(GlobalTimeStop-GlobalTimeStart,units = "secs")
    

cat("xcmsFindPeaksTime: ",xcmsFindPeaksTime,"\n");
cat("xcmsGroupTime: ",xcmsGroupTime,"\n");
cat("xcmsRetCorTime: ",xcmsRetCorTime,"\n");
cat("xcmsGroupSamplesTime: ",xcmsGroupSamplesTime,"\n");
cat("xcmsRetFillPeakTime: ",xcmsRetFillPeakTime,"\n");
cat("xcmsReportTime: ",xcmsReportTime,"\n");
cat("GlobalTime: ",GlobalTime,"\n");

print("Finished profiling xcms.") 

