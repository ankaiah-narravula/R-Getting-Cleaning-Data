run_analysis <- function() {

library(reshape2);
  
  ## Import the test data
  
  X_test<-read.table("./data/test/X_test.txt")
  Y_test<-read.table("./data/test/y_test.txt")
  sub_test<-read.table("./data/test/subject_test.txt")
  
  ## Import the training data
  X_train<-read.table("./data/train/X_train.txt")
  Y_train<-read.table("./data/train/y_train.txt")
  sub_train<-read.table("./data/train/subject_train.txt")
  
  ## Read the dataframe's column names
  features <- read.table("./data/features.txt")
  feature_names <-  features[,2]
  
  colnames(X_test) <- feature_names
  colnames(X_train) <- feature_names
  colnames(sub_test) <- "subject_id"
  colnames(sub_train) <- "subject_id"
  colnames(Y_train) <- "activity_id"
  colnames(Y_test) <- "activity_id"
  
  
  ## Task 1) Merge the training and the test sets to create one data set.

  ## Combine the training data,  data, and subject row identification into full versions of each
  X_all <- rbind(X_test, X_train)
  Y_all <- rbind(Y_test, Y_train)
  complete_data <-rbind(sub_test, sub_train)
  
  all_data <- cbind(X_all,Y_all,complete_data);

 
  ## Task 2) Extract only the measurements on the mean and standard deviation for each measurement
  
  ## The columns with the desired measurements are labeled using mean() and std() so grepl on the column names
  ## looking for partial matches will flag them. '|' will create a vector that is true if either is matched.
  requiredcols<- grepl("mean()",colnames(all_data)) | grepl("std()",colnames(all_data))
requiredcols_names <- names(all_data)[requiredcols]
  

  ## Then putting the new columns in a pared down data frame is simple:
  X_mean_std <- all_data[,c("subject_id","activity_id",requiredcols_names)]

  ## Task 3) Uses descriptive activity names to name the activities in the data set
  ## Task 4) Appropriately labels the data set with descriptive activity names. 
  
  activities<-read.table("./data/activity_labels.txt")
  colnames(activities) <- c("activity_id","activity_name")
  
  ##Merge the activities datase with the mean/std values datase 
  
        ##to get one dataset with descriptive activity names
        merge_data <- merge(activities,X_mean_std,by.x="activity_id",by.y="activity_id",all=TRUE)
        
        ##Melt the dataset with the descriptive activity names for better handling
        data_melt <- melt(merge_data,id=c("activity_id","activity_name","subject_id"))
        
        ##Cast the melted dataset according to  the average of each variable 
        ##for each activity and each subjec
        mean_data <- dcast(data_melt,activity_id + activity_name + subject_id ~ variable,mean)
       
        ## Create a file with the new tidy dataset
        write.table(mean_data,"./tidy_movement_data.txt")

}