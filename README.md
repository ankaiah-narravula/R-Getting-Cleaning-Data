
===============================================================
Script Name: run_analyis.R
Date: 25 Jan 2015
Dataset: Human Activity Recognition Using Smartphones Dataset
Version: 1.0
Author: Ankaiah Narravula
==============================================================
## About the Script

The script "run_analysis.R"  reads data from foler "data" and produces a new tidy dataset which will be required for tasks given in assignment.
The Task performed on tidy data set is computed the average of each variable for each activity and each subject and stored in separate file

The original dataset included the following data files:
=======================================================
* 'features.txt': List of all features.

* 'activity_labels.txt': List of class labels and their activity name.

* 'X_train.txt': Training set.

* 'y_train.txt': Training labels.

* 'subject_train.txt': ID's of subjects in the training data

* 'X_test.txt': Test set.

* 'y_test.txt': Test labels.

* 'subject_test.txt': ID's of subjects in the training data


## Description of the script:
==================================
The run_analysis.R script merges data from a number of .txt files and produces a tidy data set which may be used for further analysis.

- It reads text files "X_train", "y_train", and "subject_id" from folder meant for training data combines using cbind()

--It reads text files "X_test", "y_test", and "subject_id" from folder meant for test data combines using cbind()

- Combines train data and test data using rbind()

- Using the "grep" function, all the columns with mean() and std() values are extracted and then a new data frame, including only the "activity_id", the "subject_id" and the mean() and std() columns, is created    

- Using the "merge" function, descriptive activity names are merged with the mean, std values dataset, to get one dataset with descriptive activity names

- "melt" and "dcast" functions of the "reshape2" package, the data is converted into a table containing mean values of all the included features, ordered by the activity name and the subject id, and the data is written to the "tidy_movement_data.txt" file.

