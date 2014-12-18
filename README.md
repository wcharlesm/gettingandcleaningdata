# Using run_analysis.R
======================

To run the script fist set your working directory to the root directory of the project.  Verify that the unzipped UCI HAR Dataset folder is present in the project's root directory.  Then use the source command to run the script.  This will create an output file named tidyDataAverage.txt containing an average of all the Mean and Standard Deviation entries for a particular Subject, Activity and Feature.

The script will install any of it's dependencies if they are not already present on the machine where it's run.

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
