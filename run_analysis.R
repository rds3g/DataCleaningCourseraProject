library(dplyr)

###########################################################################
# run_analysis.R
#
# this is the master script for my Data Cleaning Course.
#
# Functionality is divided into two parts.
# 
# Part I works on building the variable names and analyzing which
# variables are to be included in the the analysis (those representing means
# and standard deviations)
#
# Part II does the work of merging and building the data tables, all the itermediate tables
# as well as the final table submitted
#
# Cross-references in the readme.md file are listed in comments in this script.
#
# The codebook is in codebook.md
#
#############################################################################


###########################################################################
# Part I: Develop the Features (keep the mean, and std.dev. measures, create meaningful names for variables)
###########################################################################

#setup a flag to indicate whether I should do intermediate saving to .RData files
intermediateSaves = FALSE


#set the top-Directory to where the script run_analysis.R is located
topDir <- dirname(sys.frame(1)$ofile)

if(dir.exists(topDir)){
  setwd(topDir)
} else {
  print(paste("Was not successful in setting the top-Directory"))
  print(paste("You may need to set 'topDir' manually by uncommenting one of the following lines"))
  stop("Sorry for the trouble please try to set topDir manually for this to run")
  #setwd("/full/path/to/top/directory")
  #setwd(".")
}


featuresNamesDF <- read.table("features.txt",colClasses = c("character","character"))
featuresNames_tbl <- tbl_df(featuresNamesDF)
featuresNames_tbl <- mutate(featuresNames_tbl, origDescriptors = V2 )
featuresNames_tbl <- mutate(featuresNames_tbl, enhancedDescriptors = V2)
featuresNames_tbl <- mutate(featuresNames_tbl, Keep = FALSE)
featuresNames_tbl <- mutate(featuresNames_tbl, duplicatedName = FALSE)
featuresNames_tbl <- select(featuresNames_tbl, V1, origDescriptors, enhancedDescriptors, Keep, duplicatedName)
#create a variable in featuresNames_tbl called VVector,
# this will be V1, V2, V3, ..., V561 and will be the names assigned to the
#variables by read.table() when the "X" data table is read 
VVector = rep(NA,times=nrow(featuresNames_tbl))
for (ii in seq(1,length(VVector))){
  VVector[ii]<-paste0("V",sprintf("%d",ii))
}
featuresNames_tbl <- cbind(featuresNames_tbl, VVector)


# now mark Keep = TRUE for all variable names which match on "-mean\\(\\)" or "-std()"
# Note Reqirement 2: 
#
match_ii = grep("-mean\\(\\)",featuresNames_tbl$origDescriptors,perl=TRUE)
featuresNames_tbl[match_ii,"Keep"] = TRUE
match_ii = grep("-std\\(\\)",featuresNames_tbl$origDescriptors,perl=TRUE)
featuresNames_tbl[match_ii,"Keep"] = TRUE


# this stage of the processing is enhancing the ultimate variable names
# a majority of the variables are not currently of interest, that is, not 
# a "mean" or "standard deviation" feature, these variables will be eventually dropped
# but for now, flag these with a denotation of "PendingDrop" at the end so
# that we can clearly see if an unwanted variable sneaks through at the end
pendingDrop_ii = featuresNames_tbl$Keep==FALSE
featuresNames_tbl$enhancedDescriptors[pendingDrop_ii]<- paste(featuresNames_tbl$enhancedDescriptors[pendingDrop_ii],
                                                              "PendingDrop")

#of the 561 variables in the original data, there are quite a few duplicate variable names
# find and mark these with special "WarningDuplicateNames" so we can clearly see if any of these 
# make the cut (remembering that we are only looking for the -mean() and -std() features)
duplicatedFeatureNames <- featuresNames_tbl %>% group_by(origDescriptors) %>% summarize(NbyName = n()) %>% filter(NbyName>1) %>% arrange(desc(NbyName))
for (ii in seq_along(duplicatedFeatureNames$origDescriptors)) {
  this_duplicatedName <- duplicatedFeatureNames$origDescriptors[ii]
  duplicated_indices <- which(featuresNames_tbl$origDescriptors==this_duplicatedName)
  featuresNames_tbl[duplicated_indices,"duplicatedName"] = TRUE
}
duplicated_ii = featuresNames_tbl$duplicatedName==TRUE
featuresNames_tbl$enhancedDescriptors[pendingDrop_ii]<- paste(featuresNames_tbl$enhancedDescriptors[pendingDrop_ii],
                                                              "Warning--DuplicatedName")

######################################################
# Note Requirement 3
######################################################
# Enhance the Variable Names, currently in the table featuresNames_tbl
# to improve Readability and Clarity
# for these long names, I find a mix of using "period-separated" and "UpperCamel" style provides 
# the best readability
# for guidance I used this reference paper https://journal.r-project.org/archive/2012-2/RJournal_2012-2_Baaaath.pdf
######################################################
# the leading "f" indicates a frequency domain feature, leading "t" indicates a time domain feature
# enhance these to "freqD." and "timeD", respectively
featuresNames_tbl$enhancedDescriptors <- sub("^f","freqD.",featuresNames_tbl$enhancedDescriptors)
featuresNames_tbl$enhancedDescriptors <- sub("^t","timeD.",featuresNames_tbl$enhancedDescriptors)

###################################################################
# some of the features are still linked to the specific axis of the accelerometer or gyro
# the axis "X","Y", or "Z" marker comes at the end of the name, expand these
# to ".XAxis", ".YAxis", ".ZAxis" respectively

featuresNames_tbl$enhancedDescriptors <- sub("[-]X$",".XAxis",featuresNames_tbl$enhancedDescriptors)
featuresNames_tbl$enhancedDescriptors <- sub("[-]Y$",".YAxis",featuresNames_tbl$enhancedDescriptors)
featuresNames_tbl$enhancedDescriptors <- sub("[-]Z$",".ZAxis",featuresNames_tbl$enhancedDescriptors)


# We are specifically focusing on features where mean and standard deviation measures have been applied
# these are marked in the original dataset as "-mean()" and "-std()"
# match on these, move the mean and std naming components to the end of the variable names
# and denote with ".Mean" and ".StdDev"
meanMatch_ii = grep("mean[(][)]",featuresNames_tbl$enhancedDescriptors)
# remove the "-mean()" from the middle of the name ....
featuresNames_tbl$enhancedDescriptors[meanMatch_ii]<-
  sub("-mean[(][)]","",featuresNames_tbl$enhancedDescriptors[meanMatch_ii])
# ... and add ".Mean" to the end of the name
featuresNames_tbl$enhancedDescriptors[meanMatch_ii]<- paste(featuresNames_tbl$enhancedDescriptors[meanMatch_ii],
                                                            ".Mean",sep="")
# process "-std()" like "-mean()" immediately above
stdMatch_ii = grep("-std[(][)]",featuresNames_tbl$enhancedDescriptors)
featuresNames_tbl$enhancedDescriptors[stdMatch_ii]<-
  sub("-std[(][)]","",featuresNames_tbl$enhancedDescriptors[stdMatch_ii])
featuresNames_tbl$enhancedDescriptors[stdMatch_ii]<- paste(featuresNames_tbl$enhancedDescriptors[stdMatch_ii],  ".StdDev",sep="")

if(intermediateSaves==TRUE){
  save(featuresNames_tbl,file="featuresNames.RData")  
}

################################################################################
# Part II: Read and Merge the Data
################################################################################
# # use read.table to read in the data

if(!file.exists("X_test.txt")){
  print("Data File X_test.txt could not be found in the top directory")
  print("For this script to work, the data files like X_test.txt, X_train.txt, etc ")
  print("Need to be copied to the working directory")
  print(paste("The current working directory is ",getwd()))
  stop("I ams sorry for the trouble...Please try to copy the data files to the directory where this script is running")
}
if(!file.exists("X_train.txt")){
  print("Data File X_train.txt could not be found in the top directory")
  print("For this script to work, the data files like X_test.txt, X_train.txt, etc ")
  print("Need to be copied to the working directory")
  print(paste("The current working directory is ",getwd()))
  stop("I ams sorry for the trouble...Please try to copy the data files to the directory where this script is running")
}
#OK , if both X datasets have been found, the Y and subject data should be in working directory also



XTest <-read.table("X_test.txt")
XTrain <-read.table("X_train.txt")

#########################################
# Note Requirement 4:
#########################################
#change the variable names to the cleaner-clearer names I created (currently as V1, V2,....)
names(XTest)<- featuresNames_tbl$enhancedDescriptors
names(XTrain)<- featuresNames_tbl$enhancedDescriptors

#the X data reads in the default variable names V1, V2, V3,...V561
#I will need to subset out the mean and std.dev. variables now
XTest <- XTest[,featuresNames_tbl$Keep==TRUE]
XTrain <- XTrain[,featuresNames_tbl$Keep==TRUE]



# now work on the Y data, this is the activity "Walking", "Walking Upstairs", "Walking Downstairs", etc.
YTest <- read.table("y_test.txt")
activityTest <- factor(YTest$V1)
levels(activityTest) = c('Walking.Normal','Walking.Upstairs','Walking.Downstairs','Sitting','Standing','Lying','Across.All.Activities')
YTrain <- read.table("y_train.txt")
activityTrain <- factor(YTrain$V1)
levels(activityTrain) <- levels(activityTest)

# read in the subject data
subjectTestDf <- read.table("subject_test.txt")
subjectIDTest <- subjectTestDf[, "V1"]

subjectTrainDf <- read.table("subject_train.txt")
subjectIDTrain <- subjectTrainDf[,"V1"]

# now combine the SubjectTest, ActivityTest and XTest Data into a single TestData frame
TestData <- cbind(subjectIDTest, activityTest, XTest)
TestData <- rename(TestData, subjectID=subjectIDTest, activity=activityTest)
TrainData <- cbind(subjectIDTrain, activityTrain, XTrain)
TrainData <- rename(TrainData, subjectID=subjectIDTrain, activity=activityTrain)

GalaxyPhoneWearableData <- rbind(TestData, TrainData)
#The data frame currently has "subjectID" as an integer, make this into a factor
#subjectIDasFactor <- as.factor(GalaxyPhoneWearableData$subjectID)
# now as factor with thirty levels, add a new level "Across.All.Subjects"
#levels(subjectIDasFactor) <- c(levels(subjectIDasFactor),"Accross.All.Subjects")
#levels(GalaxyPhoneWearableData$subjectID)<-levels(subjectIDasFactor)

if(intermediateSaves==TRUE){
save(GalaxyPhoneWearableData,file="GalaxyPhoneWearableData.RData")
  
}

#load("GalaxyPhoneWearableData.RData")

#now create the second data set which summarizes the variables by activity and subject
#SummarizedData <- summarise(group_by(GalaxyPhoneWearableData, activity, SubjectID), mean=mean(value))
MeansByActivityAndSubject <- GalaxyPhoneWearableData %>% group_by(activity, subjectID) %>% summarise_each(funs(mean))
GrpCount1 <- GalaxyPhoneWearableData %>% group_by(activity,subjectID) %>% summarise(groupCount=n())
#join the "GroupCount" to the data frame
MeansByActivityAndSubject <- left_join(MeansByActivityAndSubject,GrpCount1)

ungroup(MeansByActivityAndSubject)
MeansByActivityAndSubject[,"activity"] = as.character(MeansByActivityAndSubject$activity)
MeansByActivityAndSubject[,"subjectID"] = as.character(MeansByActivityAndSubject$subjectID)
MeansByActivityAndSubject = mutate(MeansByActivityAndSubject,meansSet="ByActivityAndSubject")

#######################################################
# Now work on a subset "ByActivityForAllSubjects"
MeansByActivityForAllSubjects <- GalaxyPhoneWearableData %>% group_by(activity) %>% summarise_each(funs(mean))
GrpCount2 <- GalaxyPhoneWearableData %>% group_by(activity) %>% summarise(groupCount=n())
#join the "GroupCount" to the data frame
MeansByActivityForAllSubjects <- left_join(MeansByActivityForAllSubjects,GrpCount2)

ungroup(MeansByActivityForAllSubjects)
MeansByActivityForAllSubjects[,"activity"] = as.character(MeansByActivityForAllSubjects$activity)
MeansByActivityForAllSubjects[,"subjectID"] = as.character("Across.All.Subjects")
MeansByActivityForAllSubjects = mutate(MeansByActivityForAllSubjects,meansSet="ByActivityForAllSubjects")


#this forces the subjectID to be "All.Subjects", remembering that subjectID is now a vector with factor w/levels (see above around line 155)
#######################################################
# Now work on a subset "BySubjectForAllActivities"
MeansBySubjectForAllActivities <- GalaxyPhoneWearableData %>% group_by(subjectID) %>% summarise_each(funs(mean))
GrpCount3 <- GalaxyPhoneWearableData %>% group_by(subjectID) %>% summarise(groupCount=n())
MeansBySubjectForAllActivities <- left_join(MeansBySubjectForAllActivities,GrpCount3)

ungroup(MeansBySubjectForAllActivities)
MeansBySubjectForAllActivities[,"activity"] = as.character("Across.All.Activities")
MeansBySubjectForAllActivities[,"subjectID"] = as.character(MeansBySubjectForAllActivities$subjectID)
MeansBySubjectForAllActivities = mutate(MeansBySubjectForAllActivities,meansSet="BySubjectForAllActivities")


#now combine the three datasets 
outputData <- union(MeansByActivityAndSubject,MeansByActivityForAllSubjects)
outputData <- union(outputData,MeansBySubjectForAllActivities)
outputData <- mutate(outputData,subjectIDforOrdering=as.numeric(subjectID))
outputData <- arrange(outputData,meansSet,activity,subjectIDforOrdering)
outputData <- mutate(outputData,TestPartialSum = groupCount*timeD.BodyAcc.XAxis.Mean)

#do a sanity check on the three groups, seeing in the TestPartialSum, when summed in a group, equals
SanityCheck <- outputData %>% group_by(meansSet) %>% summarize(GroupSum = sum(TestPartialSum))
SanityCheck2 <- sum(GalaxyPhoneWearableData$timeD.BodyAcc.XAxis.Mean)
#OK SanityChecks 1 and 2 both give answers of 2825.502, so it looks like the Grouping, Aggregating
#makes sense
#drop the TestPartialSum variable, keep the GroupSum variable, and then reorder the variable names
outputData <- ungroup(outputData)
outputData <- select(outputData, -TestPartialSum)
outputData <- select(outputData, activity, subjectID, groupCount, meansSet, everything())

if(intermediateSaves==TRUE){
  save(outputData,file="Requirement5asTidyOutput.RData")
}

write.table(x=outputData,file="Req5TidyData.txt",row.names=FALSE)

#how to read in the table
data <- read.table("Req5TidyData.txt", header = TRUE) 
#if they used some other way of saving the file than a default write.table, this step will be different
View(data)




