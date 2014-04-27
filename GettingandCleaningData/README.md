# Getting and Cleaning Data Peer Assignment

The data used for the peer assignment was collected from the accelerometers 
from the Samsung Galaxy S smartphone. 
The data for the project was extracted from here: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The R script called run_analysis.R that does the following.
>+ Assumes dataset from zip files were already downloaded

>+ Create activity data.frame from (activity_labes.txt) 

>+ Create test dataset by reading in and merging subject (subject_test.txt), 
>>+ activity (y_test.txt), test (X_test.txt) and features (features.txt) use 
>>+ features as the colnames of the test datasets 

>+ Create training dataset by reading in and merging subject (subject_train.txt),
>>+ activity (y_train.txt) and test (X_train.txt) and features (features.txt) use 
>>+ features as the colnames of the train datasets

>+ Merges the training and the test sets to create one data set.

>+ Extracts only the measurements on the mean and standard deviation for each measurement by
>>+ using colnames, %in% and grep (HARDatMeanStds)

>+ Uses descriptive activity names to name the activities in the data set by
>>+ using ifelse and changing 1:6 to the walking:laying using the activity dataset (activity_lables.txt) 

>+ Appropriately labels the data set with descriptive activity names using
>>+ gsub on the colnames

>+ Creates a second, independent tidy data set with the average of each variable for each 
>>+ activity and each subject using a melt and cast 

> Save tidy dataset

The independent tidy data set is called "Tidy_HAR_data.txt"

The code book describes the variables and the data is called "CodeBook.md"


