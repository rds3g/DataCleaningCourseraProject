library(dplyr)
library(knitr)

# this script generates two tables for inclusion into the codebook.md



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

load("featuresNames.RData")




duplicatedFeatureNames <- featuresNames_tbl %>% group_by(origDescriptors) %>% 
  summarize(NbyName = n()) %>% filter(NbyName>1) %>% arrange(desc(NbyName))

for (ii in seq(1, nrow(duplicatedFeatureNames)) ){
  print(paste("Working on seq ",ii))
  this_duplicate <- duplicatedFeatureNames[ii,"origDescriptors"]
  which_ii <- which(featuresNames_tbl$origDescriptors==this_duplicate)
  which_ii <- grep(this_duplicate,featuresNames_tbl$origDescriptors,fixed=TRUE)
  featuresNames_tbl$duplicatedName[which_ii] = TRUE
}

#Table a is a listing of duplicated names in the original dataset

OutputTable <- featuresNames_tbl %>% arrange(origDescriptors)
OutputTable <- OutputTable %>% filter(duplicatedName==TRUE) 
OutputTable <- select(OutputTable,V1,origDescriptors)

a<-kable(OutputTable,format="markdown")

#print(a) to list the output in md format, then manually copy to the codebook.md file

# Table b is a mapping of original variable names to the enhanced names
OutputTable <- featuresNames_tbl %>% arrange(V1)
OutputTable <- OutputTable %>%  mutate(V1forSorting=as.numeric(V1))
OutputTable <- OutputTable %>% filter(Keep==TRUE) 
OutputTable <- OutputTable %>% arrange(V1forSorting)
OutputTable <- OutputTable %>%  select(V1,origDescriptors,enhancedDescriptors)
b<-kable(OutputTable,format="markdown")

