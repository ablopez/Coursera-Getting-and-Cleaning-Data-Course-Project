## Course Project Code Book
 

Data Source: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Original description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The R script 'run_analysis.R' performs the following to clean the dataset:

1 - Merges the training and test sets to create one data set.

a) train/X_train.txt and test/X_test.txt.
The result is a 10299x561 data frame.

b) train/subject_train.txt and test/subject_test.txt. 
The result is a 10299x1 data frame with subject IDs, 

c)train/y_train.txt and test/y_test.txt.
The result is also a 10299x1 data frame with activity IDs.

2 - run_analysis.R reads features.txt and extracts the information associated to the measurements on the mean and standard deviation for each measurement. 

The result is a 10299x66 data frame.

3 - run_analysis.R reads the activity_labels.txt and applies descriptive activity names to name the activities in the data set: walking; walkingupstairs; walkingdownstairs; sitting; standing; laying
       

4 - 'run_analysis.R'appropriately labels the data set with descriptive names: all feature names (attributes) and activity names are converted to lower case, underscores while brackets () are removed. 

It merges the 10299x66 data frame containing features with 10299x1 data frames containing activity labels and subject IDs. 

The result is saved as merged_clean_data.txt, a 10299x68 data frame such that the first column contains subject IDs

         
5- Finally, the R script 'run_analysis.R' creates a 2nd, independent tidy data set with the average of each measurement for each activity and each subject. 

The result is saved as 'my_tidyData.txt', a 180x68 data frame.
There are 30 subjects and 6 activities, thus 180 rows in this data set with averages.
The file can be verified with R-studio: read.table("my_tidyData.txt")

## end file

