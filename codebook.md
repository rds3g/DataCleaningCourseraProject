<h1> Codebook for Data Cleaning Project </h1>

<h2>Feature Observation (Aggregation) Set Information Variables </h2>

The submitted dataset for Requirement 5 only contains "observations" of "means" calculated 
from subgroups of the targeted features.  Each targeted features is itself either a "mean" or "standard deviation" statistic.  The table lists the descriptive variable names (see below) but the
individual observations are either a "mean of means" or a "mean of standard deviations."
The calculated mean is therefore an average of a number of values taken across a specified subgroup.

One subgroup would be Subject 1 (subjectID=1) Walking (activity="Walking.Normal").  The GroupCount for this subgroup is 95, meaning that 95 observations were made with 561 features
for each observation.  The means reported in the table are averages from the 95 observations.

The activity variable describes the activity for each subgroub mean.  There are six specified
activities (see below) for the experiments.  However, in the table submitted, means are also
reported for subgroups made on a subject basis but spanning all six activities.  For these
marginal calculations, the activity value is "Across.All.Activities".

A similar approach is taken to aggregate in groups by activities.  For example, when 
the activity of interest is "Walking", there is an observation where the means are aggregated
across all subjects.  The "subjectID" in these observations is "Across.All.Subjects".

I have included another variable "meansSet" which details whether the observation (a row 
in the table) is associated with subgroups by subject and activity, by subject, or by activity.
This variable is redundant to the combinations of activity and subjectID.  However, I have
included this variable in the dataset to facilitate sorting of the data table and making crosschecks to see if the global sums for the three types of groups are equal to the global sum over the
combined (training+test) sets.

<h3>Why No Units are Provided</h3>
One requirement was to list the "units" of each variable.  I found this impossible to do
as the original data "README" file specifies that each variable was normalized to values from
-1 to 1.  This becomes non-sensical for the standard deviation measures.  I do not think it
possible to reverse-engineer the normalization transformations without extensive recreation
of the statistics from the raw time-domain data.  I did consider transforming the standard deviation statistics to non-negative values.  In the end, I left these as provided in the original dataset, spanning from -1 to 1.


<h3> The Aggregation Variables </h3>
|Variable Name    |Purpose    |
|:------------------------|:----------------------------|
|activity                |Lists the type of activity ("Lying","Sitting","Standing","Walking.Normal","Walking.Upstairs","Walking.Downstairs") or when aggregation spans all activities, the activity="Across.All.Activities"|
|subjectID          | the ID of the subject performing the activity ("1","2", ...,"30")  or when aggregation spans all subjects, subjectID="Across.All.Subjects" |
|groupCount     | the number of observations aggregated into the specified activity-subjectID observation of mean|
|meansSet | this has one of the following three values; "ByActivityAndSubject","ByActivityForAllSubjects","BySubjectForAllActiviities" 

<h3>Feature Variables with Expanded Descriptions</h3>

The features of interest were specified to be of type "mean" or "standard deviation" statistics.
The variable names developed in this project are given in the first column. 

 The second column "Domain" specifies the generic type of data used to derive the statistic. Specifically, whether the statistic was derived from the direct time-series data or from frequency-domain (e.g. FFT) spectral derivatives.
 
 The third column expands on the type of feature.

Many features are derived from one of the three orthoganal axes of the
 accelerometer or gyroscopic sensors.  The fourth column denotes the original sensor axis.
 Some features are derived from multiple axes; for these, the axis specification is empty.
 
 The last column "Statistic" specifies either "Mean" or "Standard Deviation".
 


|Variable Name                      |Domain Type |Feature                                |Axis |Statistic |
|:--------------------------------|:-----------|:--------------------------------------|:----|:---------|
|timeD.BodyAcc.XAxis.Mean         |Time        |Body Acceleration                      |X    |Mean      |
|timeD.BodyAcc.YAxis.Mean         |Time        |Body Acceleration                      |Y    |Mean      |
|timeD.BodyAcc.ZAxis.Mean         |Time        |Body Acceleration                      |Z    |Mean      |
|timeD.BodyAcc.XAxis.StdDev       |Time        |Body Acceleration                      |X    |Std. Dev. |
|timeD.BodyAcc.YAxis.StdDev       |Time        |Body Acceleration                      |Y    |Std. Dev. |
|timeD.BodyAcc.ZAxis.StdDev       |Time        |Body Acceleration                      |Z    |Std. Dev. |
|timeD.GravityAcc.XAxis.Mean      |Time        |Gravity Acceleration                   |X    |Mean      |
|timeD.GravityAcc.YAxis.Mean      |Time        |Gravity Acceleration                   |Y    |Mean      |
|timeD.GravityAcc.ZAxis.Mean      |Time        |Gravity Acceleration                   |Z    |Mean      |
|timeD.GravityAcc.XAxis.StdDev    |Time        |Gravity Acceleration                   |X    |Std. Dev. |
|timeD.GravityAcc.YAxis.StdDev    |Time        |Gravity Acceleration                   |Y    |Std. Dev. |
|timeD.GravityAcc.ZAxis.StdDev    |Time        |Gravity Acceleration                   |Z    |Std. Dev. |
|timeD.BodyAccJerk.XAxis.Mean     |Time        |Body Acceleration  Jerk                |X    |Mean      |
|timeD.BodyAccJerk.YAxis.Mean     |Time        |Body Acceleration  Jerk                |Y    |Mean      |
|timeD.BodyAccJerk.ZAxis.Mean     |Time        |Body Acceleration  Jerk                |Z    |Mean      |
|timeD.BodyAccJerk.XAxis.StdDev   |Time        |Body Acceleration  Jerk                |X    |Std. Dev. |
|timeD.BodyAccJerk.YAxis.StdDev   |Time        |Body Acceleration  Jerk                |Y    |Std. Dev. |
|timeD.BodyAccJerk.ZAxis.StdDev   |Time        |Body Acceleration  Jerk                |Z    |Std. Dev. |
|timeD.BodyGyro.XAxis.Mean        |Time        |Body Gyro                              |X    |Mean      |
|timeD.BodyGyro.YAxis.Mean        |Time        |Body Gyro                              |Y    |Mean      |
|timeD.BodyGyro.ZAxis.Mean        |Time        |Body Gyro                              |Z    |Mean      |
|timeD.BodyGyro.XAxis.StdDev      |Time        |Body Gyro                              |X    |Std. Dev. |
|timeD.BodyGyro.YAxis.StdDev      |Time        |Body Gyro                              |Y    |Std. Dev. |
|timeD.BodyGyro.ZAxis.StdDev      |Time        |Body Gyro                              |Z    |Std. Dev. |
|timeD.BodyGyroJerk.XAxis.Mean    |Time        |Body Gyro Jerk                         |X    |Mean      |
|timeD.BodyGyroJerk.YAxis.Mean    |Time        |Body Gyro Jerk                         |Y    |Mean      |
|timeD.BodyGyroJerk.ZAxis.Mean    |Time        |Body Gyro Jerk                         |Z    |Mean      |
|timeD.BodyGyroJerk.XAxis.StdDev  |Time        |Body Gyro Jerk                         |X    |Std. Dev. |
|timeD.BodyGyroJerk.YAxis.StdDev  |Time        |Body Gyro Jerk                         |Y    |Std. Dev. |
|timeD.BodyGyroJerk.ZAxis.StdDev  |Time        |Body Gyro Jerk                         |Z    |Std. Dev. |
|timeD.BodyAccMag.Mean            |Time        |Body Acceleration  Magnitude           |     |Mean      |
|timeD.BodyAccMag.StdDev          |Time        |Body Acceleration  Magnitude           |     |Std. Dev. |
|timeD.GravityAccMag.Mean         |Time        |Gravity Acceleration  Magnitude        |     |Mean      |
|timeD.GravityAccMag.StdDev       |Time        |Gravity Acceleration  Magnitude        |     |Std. Dev. |
|timeD.BodyAccJerkMag.Mean        |Time        |Body Acceleration  Jerk Magnitude      |     |Mean      |
|timeD.BodyAccJerkMag.StdDev      |Time        |Body Acceleration  Jerk Magnitude      |     |Std. Dev. |
|timeD.BodyGyroMag.Mean           |Time        |Body Gyro Magnitude                    |     |Mean      |
|timeD.BodyGyroMag.StdDev         |Time        |Body Gyro Magnitude                    |     |Std. Dev. |
|timeD.BodyGyroJerkMag.Mean       |Time        |Body Gyro Jerk Magnitude               |     |Mean      |
|timeD.BodyGyroJerkMag.StdDev     |Time        |Body Gyro Jerk Magnitude               |     |Std. Dev. |
|freqD.BodyAcc.XAxis.Mean         |Frequency   |Body Acceleration                      |X    |Mean      |
|freqD.BodyAcc.YAxis.Mean         |Frequency   |Body Acceleration                      |Y    |Mean      |
|freqD.BodyAcc.ZAxis.Mean         |Frequency   |Body Acceleration                      |Z    |Mean      |
|freqD.BodyAcc.XAxis.StdDev       |Frequency   |Body Acceleration                      |X    |Std. Dev. |
|freqD.BodyAcc.YAxis.StdDev       |Frequency   |Body Acceleration                      |Y    |Std. Dev. |
|freqD.BodyAcc.ZAxis.StdDev       |Frequency   |Body Acceleration                      |Z    |Std. Dev. |
|freqD.BodyAccJerk.XAxis.Mean     |Frequency   |Body Acceleration  Jerk                |X    |Mean      |
|freqD.BodyAccJerk.YAxis.Mean     |Frequency   |Body Acceleration  Jerk                |Y    |Mean      |
|freqD.BodyAccJerk.ZAxis.Mean     |Frequency   |Body Acceleration  Jerk                |Z    |Mean      |
|freqD.BodyAccJerk.XAxis.StdDev   |Frequency   |Body Acceleration  Jerk                |X    |Std. Dev. |
|freqD.BodyAccJerk.YAxis.StdDev   |Frequency   |Body Acceleration  Jerk                |Y    |Std. Dev. |
|freqD.BodyAccJerk.ZAxis.StdDev   |Frequency   |Body Acceleration  Jerk                |Z    |Std. Dev. |
|freqD.BodyGyro.XAxis.Mean        |Frequency   |Body Gyro                              |X    |Mean      |
|freqD.BodyGyro.YAxis.Mean        |Frequency   |Body Gyro                              |Y    |Mean      |
|freqD.BodyGyro.ZAxis.Mean        |Frequency   |Body Gyro                              |Z    |Mean      |
|freqD.BodyGyro.XAxis.StdDev      |Frequency   |Body Gyro                              |X    |Std. Dev. |
|freqD.BodyGyro.YAxis.StdDev      |Frequency   |Body Gyro                              |Y    |Std. Dev. |
|freqD.BodyGyro.ZAxis.StdDev      |Frequency   |Body Gyro                              |Z    |Std. Dev. |
|freqD.BodyAccMag.Mean            |Frequency   |Body Acceleration  Magnitude           |     |Mean      |
|freqD.BodyAccMag.StdDev          |Frequency   |Body Acceleration  Magnitude           |     |Std. Dev. |
|freqD.BodyBodyAccJerkMag.Mean    |Frequency   |Body Body Acceleration  Jerk Magnitude |     |Mean      |
|freqD.BodyBodyAccJerkMag.StdDev  |Frequency   |Body Body Acceleration  Jerk Magnitude |     |Std. Dev. |
|freqD.BodyBodyGyroMag.Mean       |Frequency   |Body Body Gyro Magnitude               |     |Mean      |
|freqD.BodyBodyGyroMag.StdDev     |Frequency   |Body Body Gyro Magnitude               |     |Std. Dev. |
|freqD.BodyBodyGyroJerkMag.Mean   |Frequency   |Body Body Gyro Jerk Magnitude          |     |Mean      |
|freqD.BodyBodyGyroJerkMag.StdDev |Frequency   |Body Body Gyro Jerk Magnitude          |     |Std. Dev. |

<h2>Mapping Original Data Names to Enhanced Variable Names</h2>
This table maps the names given in the original data to the names created in
this project.

|V1  |origDescriptors             |enhancedDescriptors              |
|:---|:---------------------------|:--------------------------------|
|1   |tBodyAcc-mean()-X           |timeD.BodyAcc.XAxis.Mean         |
|2   |tBodyAcc-mean()-Y           |timeD.BodyAcc.YAxis.Mean         |
|3   |tBodyAcc-mean()-Z           |timeD.BodyAcc.ZAxis.Mean         |
|4   |tBodyAcc-std()-X            |timeD.BodyAcc.XAxis.StdDev       |
|5   |tBodyAcc-std()-Y            |timeD.BodyAcc.YAxis.StdDev       |
|6   |tBodyAcc-std()-Z            |timeD.BodyAcc.ZAxis.StdDev       |
|41  |tGravityAcc-mean()-X        |timeD.GravityAcc.XAxis.Mean      |
|42  |tGravityAcc-mean()-Y        |timeD.GravityAcc.YAxis.Mean      |
|43  |tGravityAcc-mean()-Z        |timeD.GravityAcc.ZAxis.Mean      |
|44  |tGravityAcc-std()-X         |timeD.GravityAcc.XAxis.StdDev    |
|45  |tGravityAcc-std()-Y         |timeD.GravityAcc.YAxis.StdDev    |
|46  |tGravityAcc-std()-Z         |timeD.GravityAcc.ZAxis.StdDev    |
|81  |tBodyAccJerk-mean()-X       |timeD.BodyAccJerk.XAxis.Mean     |
|82  |tBodyAccJerk-mean()-Y       |timeD.BodyAccJerk.YAxis.Mean     |
|83  |tBodyAccJerk-mean()-Z       |timeD.BodyAccJerk.ZAxis.Mean     |
|84  |tBodyAccJerk-std()-X        |timeD.BodyAccJerk.XAxis.StdDev   |
|85  |tBodyAccJerk-std()-Y        |timeD.BodyAccJerk.YAxis.StdDev   |
|86  |tBodyAccJerk-std()-Z        |timeD.BodyAccJerk.ZAxis.StdDev   |
|121 |tBodyGyro-mean()-X          |timeD.BodyGyro.XAxis.Mean        |
|122 |tBodyGyro-mean()-Y          |timeD.BodyGyro.YAxis.Mean        |
|123 |tBodyGyro-mean()-Z          |timeD.BodyGyro.ZAxis.Mean        |
|124 |tBodyGyro-std()-X           |timeD.BodyGyro.XAxis.StdDev      |
|125 |tBodyGyro-std()-Y           |timeD.BodyGyro.YAxis.StdDev      |
|126 |tBodyGyro-std()-Z           |timeD.BodyGyro.ZAxis.StdDev      |
|161 |tBodyGyroJerk-mean()-X      |timeD.BodyGyroJerk.XAxis.Mean    |
|162 |tBodyGyroJerk-mean()-Y      |timeD.BodyGyroJerk.YAxis.Mean    |
|163 |tBodyGyroJerk-mean()-Z      |timeD.BodyGyroJerk.ZAxis.Mean    |
|164 |tBodyGyroJerk-std()-X       |timeD.BodyGyroJerk.XAxis.StdDev  |
|165 |tBodyGyroJerk-std()-Y       |timeD.BodyGyroJerk.YAxis.StdDev  |
|166 |tBodyGyroJerk-std()-Z       |timeD.BodyGyroJerk.ZAxis.StdDev  |
|201 |tBodyAccMag-mean()          |timeD.BodyAccMag.Mean            |
|202 |tBodyAccMag-std()           |timeD.BodyAccMag.StdDev          |
|214 |tGravityAccMag-mean()       |timeD.GravityAccMag.Mean         |
|215 |tGravityAccMag-std()        |timeD.GravityAccMag.StdDev       |
|227 |tBodyAccJerkMag-mean()      |timeD.BodyAccJerkMag.Mean        |
|228 |tBodyAccJerkMag-std()       |timeD.BodyAccJerkMag.StdDev      |
|240 |tBodyGyroMag-mean()         |timeD.BodyGyroMag.Mean           |
|241 |tBodyGyroMag-std()          |timeD.BodyGyroMag.StdDev         |
|253 |tBodyGyroJerkMag-mean()     |timeD.BodyGyroJerkMag.Mean       |
|254 |tBodyGyroJerkMag-std()      |timeD.BodyGyroJerkMag.StdDev     |
|266 |fBodyAcc-mean()-X           |freqD.BodyAcc.XAxis.Mean         |
|267 |fBodyAcc-mean()-Y           |freqD.BodyAcc.YAxis.Mean         |
|268 |fBodyAcc-mean()-Z           |freqD.BodyAcc.ZAxis.Mean         |
|269 |fBodyAcc-std()-X            |freqD.BodyAcc.XAxis.StdDev       |
|270 |fBodyAcc-std()-Y            |freqD.BodyAcc.YAxis.StdDev       |
|271 |fBodyAcc-std()-Z            |freqD.BodyAcc.ZAxis.StdDev       |
|345 |fBodyAccJerk-mean()-X       |freqD.BodyAccJerk.XAxis.Mean     |
|346 |fBodyAccJerk-mean()-Y       |freqD.BodyAccJerk.YAxis.Mean     |
|347 |fBodyAccJerk-mean()-Z       |freqD.BodyAccJerk.ZAxis.Mean     |
|348 |fBodyAccJerk-std()-X        |freqD.BodyAccJerk.XAxis.StdDev   |
|349 |fBodyAccJerk-std()-Y        |freqD.BodyAccJerk.YAxis.StdDev   |
|350 |fBodyAccJerk-std()-Z        |freqD.BodyAccJerk.ZAxis.StdDev   |
|424 |fBodyGyro-mean()-X          |freqD.BodyGyro.XAxis.Mean        |
|425 |fBodyGyro-mean()-Y          |freqD.BodyGyro.YAxis.Mean        |
|426 |fBodyGyro-mean()-Z          |freqD.BodyGyro.ZAxis.Mean        |
|427 |fBodyGyro-std()-X           |freqD.BodyGyro.XAxis.StdDev      |
|428 |fBodyGyro-std()-Y           |freqD.BodyGyro.YAxis.StdDev      |
|429 |fBodyGyro-std()-Z           |freqD.BodyGyro.ZAxis.StdDev      |
|503 |fBodyAccMag-mean()          |freqD.BodyAccMag.Mean            |
|504 |fBodyAccMag-std()           |freqD.BodyAccMag.StdDev          |
|516 |fBodyBodyAccJerkMag-mean()  |freqD.BodyBodyAccJerkMag.Mean    |
|517 |fBodyBodyAccJerkMag-std()   |freqD.BodyBodyAccJerkMag.StdDev  |
|529 |fBodyBodyGyroMag-mean()     |freqD.BodyBodyGyroMag.Mean       |
|530 |fBodyBodyGyroMag-std()      |freqD.BodyBodyGyroMag.StdDev     |
|542 |fBodyBodyGyroJerkMag-mean() |freqD.BodyBodyGyroJerkMag.Mean   |
