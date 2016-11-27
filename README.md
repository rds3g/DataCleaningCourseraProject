
<h1> Getting and Cleaning Data Course Project</h1>

<h3>Important Note for running run_analysis.R</h3>
A required submission for this project is run_analysis.R.  This is the main script, and the main focus of this README.md.
It is not clear before submitting whether you the grader will need to run this script.  If running run_analysis.R is necessary, the underlying raw data files will need to be in the working directory to which my run_analysis.R script is placed after downloading from my github repository.  

I developed run_analysis.R with RStudio in a linux environment.  The script tries to set the working directory to be the
directory where the downloaded run_analysis.R is stored.  There is a chance of platform compatibility introducing problems here as I have not tested on other platforms like the MAC or windows.  If you have problems running, please try setting the topDir to be the working directory where the script run_analysis.R is stored.  The working data sets (X_test.txt, X_train.txt) need to be in this directory also.


<h3> Recap of the Original Data Set</h3>

The original data sets contained 561 processed features derived from the captured accelerometer and gyro data.  The targeted subset of data were the features calculated with  *mean* and *standard deviation* statistics.

<h3>The Features of Interest: Means and Standard Deviations</h3>

The feature names created by the original researchers are provided in "features.txt."  The mean and standard deviation features have original names with "-mean()" and "-std()" in their names. These are the variables which have been selected for the final data.  There are other feature names which include Mean, for example, Variable 294 is "fBodyAcc-meanFreq()-X" but I presume that this, and similarly named features, are not statistics of interest in this assignment.

From the original data source, we learn that the features are derived from the the original time-series data (e.g. time domain) and from spectral (e.g. Fast Fourier Transform) data.  Subsets of each, time- and frequency-domain features are of the targeted types (mean and standard deviation).


<h3>Renaming the Variables</h3>
A primary requirement for this project is to rename the features with a consistent, easy to understand convention amenable to further downstream R programming.  The new variable names, along with the original names, are provided in a separate markdown file "Codebook.md".

As an example, the first variable was named "tBodyAcc-mean()-X".  This is a time-domain feature (indicated by the leading t).  "BodyAcc" means "Body Acceleration".  This is a *mean* statistic (indicated by "-mean()") derived from data along the X-axis.  

I used a mixed convention of "UpperCamel" and "period-separated" styles in renaming the variables. [For reference see this paper.](https://journal.r-project.org/archive/2012-2/RJournal_2012-2_Baaaath.pdf) 
I think Professor Leek's preference is to not use period-seperated variable names.  Given my choice to bring in three or four pieces of information, I found that the use of period separators mixed with the "UpperCamel" convention improved readabilty.

Some mention was made in class about not using capitalization in variable names.  I find this is not a major problem when using modern IDE environments like RStudio as the auto-expansion of variable names reduces the annoyance of including capitalization.

The first feature "tBodyAcc-mean()-X" was renamed to "timeD.BodyAcc.XAxis.Mean."  All of the new names end with either "Mean" or "StdDev."  Features specific to an axis include a sub-field of X-Axis, Y-Axis, or Z-Axis.  The type of feature (e.g. "BodyAcc") is in the second sub-field.  The first sub-field is either "timeD" or "freqD" for time and frequency domain respectively.

The abbreviated name-snippets are generally easily understood.  Above, "Acc" is interpreted as acceleration.  Similarly, "mag" is interpreted as magnitude.

<h2>Duplicated Features Names</h2>
I found that the original variable names from "features.txt" have a number of names duplicated three times.  Perhaps the axis (X, Y, Z) identifiers were dropped.  In any case, these measures were not mean or standard deviation statistics, meaning they were to be dropped anyway.  I did not investigate to see if the data was also duplicated since they were to be dropped anyway.  The duplicated variable names from the original dataset are listed in "DuplicatedOriginalFeatures.md".


<h2>How does the script work?</h2>

The submitted processing script run_analysis.R is divided, with comments,  into two main parts. 

 Part I focuses on processing the variable names used in the final tidy data sets.  The variable names from the original dataset are loaded from "features.txt".  An immediate conversion with `dplyr:tbl_df()` facilitates many of the operations made easy with the dplyr package.  A variable in the table "featuresNames_tbl" called "Keep" is a logical vector where I maintain a list of variables to be included in the final dataset.

 "Keep" is set to TRUE for original names matching "-mean()" or "-std()".

In utilizing the subject material, regular expression functions (`grep(), sub()`) are used to transform and improve the clarity and readability of the variable names.

The enhanced variable names are stored in the table as "enhancedDescriptors".

 
 In Part II of run_analysis.R, the processing reads in the test and
 training data from X\_test.txt and X\_train.txt, respectively.  The "X" data frames are subsetted down by the "keep" variable described above. A renaming operation replaces the variable names V1, V2, ...etc
 with the new enhanced names created in Part I.
 
 The Y data, or activity data, is read in next.  The two data files, one each for training and test data, include a code ranging from 1 to 6 to
 encode the activity for each observation. I don't make an immediate change to readable activity names. Instead, I converted the "Y" vector to type factor with levels encoding readable names for the activities.
 Further discussion of how I met this requirement (3) is provided below.
 
 The subject data containing the ID of the test subject for each observation is read in.
 
 Several joining operations are made to create  intermediate data tables. 
 The cbind function is used to column-wise join the subjectID,  activity, and the feature statistics (stored in the *X* table).  First, the "TestData" table is synthesized followed by "TrainData" table.
 
 These tables, "TestData" and "TrainData", are then combined to a final table "GalaxyPhoneWearableData" with the `rbind()` function.
 
 Three different tables are then created by applying the desired groupings (by "activity" and "subjectID", by "activity" only, and by "subjectID"  only).
 
 I convert the "activity" and "subjectID" variables from factors to character types to facilitate clean joining with the `dplyr:union()` function.
 
 The final join operation gives the desired final table ("outputTable")
 which is saved as directed with `write.table()`.
 The datafile is named "Req5TidyData.txt".
  
 For reference, this command will read the table into a dataframe
 called "data".
	 `data <- read.table("Req5TidyData.txt", header = TRUE)` 
 
 
 
 <h1>Meeting the Requirements</h1>

Several Requirements are Described in the Project Instructions.
Here are details on how these requirements are met.

1. **Merges the Training and Data Set**
      * The outline of how the merging of the training and dataset are given above.  The script run_analysis.R also provides comments along the way.
2. **Extracts only the measurements on the mean and standard deviation for each measurement.**
     * I chose to include the mean and standard deviations marked in the original naming scheme with -mean() and -std()
     * The grep operations are found near comment "# Note Requirement 2a:  in run_analysis.R.
3. **Uses descriptive activity names to name the activities in the data set.**
     * Using R-functions discussed in lectures, I enhanced the readability of the variable names.  See comment "# Note Requirement 3" in run_analysis.R.
     * For example, I replace the simple leading "f" or "t" with "freqD" and "timeD" respectively.
     * The original naming convention included "-" in the name; this can cause problems in scripting languages.  The mean and standard deviation markers where attached at the end of the variable name.
     * I chose to use a hybrid of "UpperCamel" and period-separated conventions in my variable naming.  For reference, see [this paper.]
     (https://journal.r-project.org/archive/2012-2/RJournal_2012-2_Baaaath.pdf) 
     * In lecture, Professor Leek expressed his preference for lowercase variable names.  I personally use the UpperCamel syntax in other environments so I find it easy to use.  I also tend to use longer variable names as modern IDE environments like RStudio tend to reduce the typing load by expanding out previously defined variables. 
4. **Appropriately labels the data set with descriptive variable names.**
      * The default variable names were replaced with the enhanced variable names.  See comment "# Note Requirement 4" in run_analysis.R to see how this was done.
      * The enhanced variable names are described in the codebook.
5. **From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.**
       * The gist of the problem!
       * The following section in this Readme.md discusses how the submitted dataset meets the Tidy Requirement.
       
       <h2> How the Submitted DataSet is Tidy </h2>
       
   To recap, the dataset submitted from the final step contains mean values calculated from subsets of the data, with some of the features themselves calculated means.
   
  My original interpretation was to subset, or group, the data so that each subset grouped the observations for each subject performing each activity.  This would give 180 observations (or rows in the final table), 30 subjects times 6 activities.  
  
 Further reading on the discussion board indicates that the marginal statistics may also be of interest.  For example, how does the mean of a particular measure average out for a specific subject across all six activities.  This type of aggregation would give 30 observations (one for each subject).
 
 Or, how does a particular feature average out for an activity across all 30 subjects.  This type of aggregation would give 6 six observations.
 
 Any, and all of these aggregations may be of interest. 
 
 But how can these be represented in a tidy manner in one table?
 
 My approach is to keep the "activity"  and "subjectID" variables along with variables of interest.  
 
 I add a level to each variable "activity" and "subjectID".  So "activity" could be encodeded as "Walking.Normal" or "Walking.Upstairs" when focused on a specific activity.  However, when focused on all activities for a specified subject, the encoding for activity would be "Across.All.Activities" indicating for a specific subject we are averaging the means for all activities.
 
 Similarly,  the "subjectID" can take on a value of "Across.All.Subjects" when grouping is done by "activity" only.
 
 Now back to the question of whether the dataset is Tidy. One requirement of a Tidy-dataset is that "each row of the data represents a single observation."
 
 With my approach, each row, or observation, is specific to aggregation operated on in two-dimensions.
 
 For an analogy, consider that one or both eyes are used for observing.  Say the right eye distinctishes "Subjects" and left distinquishes "Activities".  Observing with both eyes allows discerning
( and grouping or aggregating ) by both activity and subject.  Observing with the right eye allows for grouping by subject (with activities blurred or averaged out) while obsering with the left eye allows grouping by activity only (with the subjects blurred or averaged out).
 
 Looking at the data with "both eyes", "right eye only", or "left eye only" all produce  valid *observations*!
 
 So, each row of the dataset contains a unique observation into aggregated means but the level of aggregation in the two dimensions of activity and subject varies for each row.
 
 Another requirement is that each column represents only one variable.  A primary focus in this project was to create a better naming convention for the variables of interest.  In this case, the targeted variables (mean and standard deviation) measures carry over on a one-to-one basis from the intermediate table created in Steps 1 through 4 to the submitted table produced for Step 5.  No other variables were created (other than two variables added to help in sorting and data validation; see my codebook).
 
 It is preferred that tidy-data be captured in one table.  This was accomplished to meet requirement 5 so no linking variables between multiple tables are needed.  Furthermore, tidy-data should be represented in one table for type of observation.  In this case, the single type of observation is an aggregated mean calculation, all  captured in the one table.
 
 So in summary, my dataset is tidy in these ways:
  1. One table is used to represent one type of observation.
  2. Each row of the table represents a single observation.
  3. Each column of the table represents a single variable.
  
  
 
 
 
 
