#Setting the directory
setwd("C:/Users/ACER/Desktop/CMSC197/2nd Mini Project")
getwd()

#Downloading the file
if(!file.exists("./specdata")){dir.create("./specdata")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./specdata/UCI_HAR_Dataset.zip")

#Unzip the file
unzip(zipfile="./specdata/UCI_HAR_Dataset.zip",exdir="./specdata")

#Putting the unzipped files in the folder "UCI HAR Dataset"
path_rf <- file.path("./specdata" , "UCI HAR Dataset")
files<-list.files(path_rf, recursive=TRUE)

#Reading the Activity files
ActivityTest  <- read.table(file.path(path_rf, "test" , "Y_test.txt" ),header = FALSE)
ActivityTrain <- read.table(file.path(path_rf, "train", "Y_train.txt"),header = FALSE)

#Reading the Subject files
SubjectTrain <- read.table(file.path(path_rf, "train", "subject_train.txt"),header = FALSE)
SubjectTest  <- read.table(file.path(path_rf, "test" , "subject_test.txt"),header = FALSE)

#Reading Features files
FeaturesTest  <- read.table(file.path(path_rf, "test" , "X_test.txt" ),header = FALSE)
FeaturesTrain <- read.table(file.path(path_rf, "train", "X_train.txt"),header = FALSE)

# Merges the training and the test sets to create one data set.
#Concatenate the data table by rows
Subject <- rbind(SubjectTrain, SubjectTest)
Activity<- rbind(ActivityTrain, ActivityTest)
Features<- rbind(FeaturesTrain, FeaturesTest)

#Setting names to variables
names(Subject)<-c("subject")
names(Activity)<- c("activity")
FeaturesNames <- read.table(file.path(path_rf, "features.txt"),head=FALSE)
names(Features)<- FeaturesNames$V2

#Merging columns
Combine <- cbind(Subject, Activity)
Data <- cbind(Features, Combine)

# Extracting only the measurements on the mean and standard deviation for each measurement
dataFeaturesNames<-FeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", FeaturesNames$V2)]

selectedNames<-c(as.character(dataFeaturesNames), "subject", "activity" )
Data<-subset(Data,select=selectedNames)

# Uses descriptive activity names to name the activities in the dataset
#Reading activity names from "activity_labels.txt"
activityLabels <- read.table(file.path(path_rf, "activity_labels.txt"),header = FALSE)

# Appropriately labels the data set with descriptive variable names
names(Data)<-gsub("^t", "Time", names(Data))
names(Data)<-gsub("^f", "Frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))

#creating a second, independent tidy data set with the average of each variable
#for each activity and each subject.

library(plyr);
Data2<-aggregate(. ~subject + activity, Data, mean)
Data2<-Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file = "TidyData.txt",row.name=FALSE)