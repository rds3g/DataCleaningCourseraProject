library(dplyr)
library(knitr)

###########################################################################
# Part I: Develop the Features (keep the mean, and std.dev. measures, create meaningful names for variables)
###########################################################################

#set the top-Directory to where the script run_analysis.R is located
topDir <- dirname(sys.frame(1)$ofile)

if(dir.exists(topDir)){
  setwd(topDir)
} else {
  print(paste("Was not successful in setting the top-Directory"))
  print(paste("You may need to set 'topDir' manually by uncommenting one of the following lines"))
  #setwd("/full/path/to/top/directory")
  #setwd(".")
}


featuresNamesDF <- read.table("features.txt",colClasses = c("character","character"))

featuresNames_tbl <- tbl_df(featuresNamesDF) %>% mutate(duplicatedFlag=FALSE)
names(featuresNames_tbl) <- c('origIndex','origDescriptor','duplicatedFlag')


duplicatedFeatureNames <- featuresNames_tbl %>% group_by(origDescriptor) %>% summarize(NbyName = n()) %>% filter(NbyName>1) %>% arrange(desc(NbyName))

for (ii in seq(1, nrow(duplicatedFeatureNames)) ){
   this_duplicate <- duplicatedFeatureNames[ii,"origDescriptor"]
   which_ii <- which(featuresNames_tbl$origDescriptor==this_duplicate)
   which_ii <- grep(this_duplicate,featuresNames_tbl$origDescriptor,fixed=TRUE)
   featuresNames_tbl$duplicatedFlag[which_ii] <- TRUE
}

OutputTable <- featuresNames_tbl %>% arrange(origDescriptor)
OutputTable <- OutputTable %>% filter(duplicatedFlag==TRUE) 
OutputTabel <- OutputTable %>%  select(origIndex,origDescriptor) 
OutputTable <- OutputTable %>% rename(VIndex=origIndex, originalFeatureName = origDescriptor)
OutputTable <- select(OutputTable,VIndex,originalFeatureName)

a<-kable(OutputTable,format="markdown")