# The Following was Applied to the UCI HAR Dataset to Produce tidyDataAverage.txt
1) Import human readable Activity Labels with their associated id numbers
2) Import human readable Feature Labels with their associated id numbers

Steps 3 - 6 were first applied to Test data, then repeated on Training Data
3) Import record of Activity Types from the test data.  Join that data with the human readable description / label for each Activity
4) Import Subject ids from the test data.
5) Import measurements from the test data, set the appropriate features as column labels / names
6) combine the Subject id and Activity type with the measurements

7) combine test and training data
8) subset data to include only columns whose names are associated with Standard Deviation and Mean calculations
9) melt data so that each row has only one measured variable
10) aggregate all measurements that represent the same Subject, Activity and Feature being measured then take the mean of that aggregate data

# Here's a brief description of the data present in each column of tidyDataAverage.txt
Subject - a unique identifying number for each participant tracked in the original study
Activity - human readable description of the Activity being performed when the measurement was taken.  Possible Activities include: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING
Feature - Measurement tracked as part of the study.  tidyDataAverage.txt only contains Features associated with Means and Standard Deviations of the measures.  For more information on the various features read the features_info.txt file in the UCI HAR Dataset folder
Average - This is a mean of the associated with a unique Subject, Activity and Feature combination.