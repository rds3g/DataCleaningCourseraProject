<h1>Duplicated Feature Names in Original Galaxy Phone Data</h1>

Vindex is the numerical line index from features.txt.
"origFeatureName" is the name from features.txt, corresponding
to the index into the original data of 561 variables.

See Readme.md for more information on how these were found.

The processing script to identify the duplicated names is
AuxScript3.R.

These features are not of the type we are interested in for this project 
(mean and standard deviation).  They are NOT included in the tidy data outputs.

|V       |Original Feature Name              |
|:------|:--------------------------------|
|311    |fBodyAcc-bandsEnergy()-1,16      |
|325    |fBodyAcc-bandsEnergy()-1,16      |
|339    |fBodyAcc-bandsEnergy()-1,16      |
|315    |fBodyAcc-bandsEnergy()-1,24      |
|329    |fBodyAcc-bandsEnergy()-1,24      |
|343    |fBodyAcc-bandsEnergy()-1,24      |
|305    |fBodyAcc-bandsEnergy()-17,24     |
|319    |fBodyAcc-bandsEnergy()-17,24     |
|333    |fBodyAcc-bandsEnergy()-17,24     |
|312    |fBodyAcc-bandsEnergy()-17,32     |
|326    |fBodyAcc-bandsEnergy()-17,32     |
|340    |fBodyAcc-bandsEnergy()-17,32     |
|303    |fBodyAcc-bandsEnergy()-1,8       |
|317    |fBodyAcc-bandsEnergy()-1,8       |
|331    |fBodyAcc-bandsEnergy()-1,8       |
|306    |fBodyAcc-bandsEnergy()-25,32     |
|320    |fBodyAcc-bandsEnergy()-25,32     |
|334    |fBodyAcc-bandsEnergy()-25,32     |
|316    |fBodyAcc-bandsEnergy()-25,48     |
|330    |fBodyAcc-bandsEnergy()-25,48     |
|344    |fBodyAcc-bandsEnergy()-25,48     |
|307    |fBodyAcc-bandsEnergy()-33,40     |
|321    |fBodyAcc-bandsEnergy()-33,40     |
|335    |fBodyAcc-bandsEnergy()-33,40     |
|313    |fBodyAcc-bandsEnergy()-33,48     |
|327    |fBodyAcc-bandsEnergy()-33,48     |
|341    |fBodyAcc-bandsEnergy()-33,48     |
|308    |fBodyAcc-bandsEnergy()-41,48     |
|322    |fBodyAcc-bandsEnergy()-41,48     |
|336    |fBodyAcc-bandsEnergy()-41,48     |
|309    |fBodyAcc-bandsEnergy()-49,56     |
|323    |fBodyAcc-bandsEnergy()-49,56     |
|337    |fBodyAcc-bandsEnergy()-49,56     |
|314    |fBodyAcc-bandsEnergy()-49,64     |
|328    |fBodyAcc-bandsEnergy()-49,64     |
|342    |fBodyAcc-bandsEnergy()-49,64     |
|310    |fBodyAcc-bandsEnergy()-57,64     |
|324    |fBodyAcc-bandsEnergy()-57,64     |
|338    |fBodyAcc-bandsEnergy()-57,64     |
|304    |fBodyAcc-bandsEnergy()-9,16      |
|318    |fBodyAcc-bandsEnergy()-9,16      |
|332    |fBodyAcc-bandsEnergy()-9,16      |
|390    |fBodyAccJerk-bandsEnergy()-1,16  |
|404    |fBodyAccJerk-bandsEnergy()-1,16  |
|418    |fBodyAccJerk-bandsEnergy()-1,16  |
|394    |fBodyAccJerk-bandsEnergy()-1,24  |
|408    |fBodyAccJerk-bandsEnergy()-1,24  |
|422    |fBodyAccJerk-bandsEnergy()-1,24  |
|384    |fBodyAccJerk-bandsEnergy()-17,24 |
|398    |fBodyAccJerk-bandsEnergy()-17,24 |
|412    |fBodyAccJerk-bandsEnergy()-17,24 |
|391    |fBodyAccJerk-bandsEnergy()-17,32 |
|405    |fBodyAccJerk-bandsEnergy()-17,32 |
|419    |fBodyAccJerk-bandsEnergy()-17,32 |
|382    |fBodyAccJerk-bandsEnergy()-1,8   |
|396    |fBodyAccJerk-bandsEnergy()-1,8   |
|410    |fBodyAccJerk-bandsEnergy()-1,8   |
|385    |fBodyAccJerk-bandsEnergy()-25,32 |
|399    |fBodyAccJerk-bandsEnergy()-25,32 |
|413    |fBodyAccJerk-bandsEnergy()-25,32 |
|395    |fBodyAccJerk-bandsEnergy()-25,48 |
|409    |fBodyAccJerk-bandsEnergy()-25,48 |
|423    |fBodyAccJerk-bandsEnergy()-25,48 |
|386    |fBodyAccJerk-bandsEnergy()-33,40 |
|400    |fBodyAccJerk-bandsEnergy()-33,40 |
|414    |fBodyAccJerk-bandsEnergy()-33,40 |
|392    |fBodyAccJerk-bandsEnergy()-33,48 |
|406    |fBodyAccJerk-bandsEnergy()-33,48 |
|420    |fBodyAccJerk-bandsEnergy()-33,48 |
|387    |fBodyAccJerk-bandsEnergy()-41,48 |
|401    |fBodyAccJerk-bandsEnergy()-41,48 |
|415    |fBodyAccJerk-bandsEnergy()-41,48 |
|388    |fBodyAccJerk-bandsEnergy()-49,56 |
|402    |fBodyAccJerk-bandsEnergy()-49,56 |
|416    |fBodyAccJerk-bandsEnergy()-49,56 |
|393    |fBodyAccJerk-bandsEnergy()-49,64 |
|407    |fBodyAccJerk-bandsEnergy()-49,64 |
|421    |fBodyAccJerk-bandsEnergy()-49,64 |
|389    |fBodyAccJerk-bandsEnergy()-57,64 |
|403    |fBodyAccJerk-bandsEnergy()-57,64 |
|417    |fBodyAccJerk-bandsEnergy()-57,64 |
|383    |fBodyAccJerk-bandsEnergy()-9,16  |
|397    |fBodyAccJerk-bandsEnergy()-9,16  |
|411    |fBodyAccJerk-bandsEnergy()-9,16  |
|469    |fBodyGyro-bandsEnergy()-1,16     |
|483    |fBodyGyro-bandsEnergy()-1,16     |
|497    |fBodyGyro-bandsEnergy()-1,16     |
|473    |fBodyGyro-bandsEnergy()-1,24     |
|487    |fBodyGyro-bandsEnergy()-1,24     |
|501    |fBodyGyro-bandsEnergy()-1,24     |
|463    |fBodyGyro-bandsEnergy()-17,24    |
|477    |fBodyGyro-bandsEnergy()-17,24    |
|491    |fBodyGyro-bandsEnergy()-17,24    |
|470    |fBodyGyro-bandsEnergy()-17,32    |
|484    |fBodyGyro-bandsEnergy()-17,32    |
|498    |fBodyGyro-bandsEnergy()-17,32    |
|461    |fBodyGyro-bandsEnergy()-1,8      |
|475    |fBodyGyro-bandsEnergy()-1,8      |
|489    |fBodyGyro-bandsEnergy()-1,8      |
|464    |fBodyGyro-bandsEnergy()-25,32    |
|478    |fBodyGyro-bandsEnergy()-25,32    |
|492    |fBodyGyro-bandsEnergy()-25,32    |
|474    |fBodyGyro-bandsEnergy()-25,48    |
|488    |fBodyGyro-bandsEnergy()-25,48    |
|502    |fBodyGyro-bandsEnergy()-25,48    |
|465    |fBodyGyro-bandsEnergy()-33,40    |
|479    |fBodyGyro-bandsEnergy()-33,40    |
|493    |fBodyGyro-bandsEnergy()-33,40    |
|471    |fBodyGyro-bandsEnergy()-33,48    |
|485    |fBodyGyro-bandsEnergy()-33,48    |
|499    |fBodyGyro-bandsEnergy()-33,48    |
|466    |fBodyGyro-bandsEnergy()-41,48    |
|480    |fBodyGyro-bandsEnergy()-41,48    |
|494    |fBodyGyro-bandsEnergy()-41,48    |
|467    |fBodyGyro-bandsEnergy()-49,56    |
|481    |fBodyGyro-bandsEnergy()-49,56    |
|495    |fBodyGyro-bandsEnergy()-49,56    |
|472    |fBodyGyro-bandsEnergy()-49,64    |
|486    |fBodyGyro-bandsEnergy()-49,64    |
|500    |fBodyGyro-bandsEnergy()-49,64    |
|468    |fBodyGyro-bandsEnergy()-57,64    |
|482    |fBodyGyro-bandsEnergy()-57,64    |
|496    |fBodyGyro-bandsEnergy()-57,64    |
|462    |fBodyGyro-bandsEnergy()-9,16     |
|476    |fBodyGyro-bandsEnergy()-9,16     |
|490    |fBodyGyro-bandsEnergy()-9,16     |
