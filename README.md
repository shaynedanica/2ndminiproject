The goal of this code is to clean and tidy a given data. The following steps were taken to create the final tidy data.

Preliminary step
1. Setting the directory using setwd() and getwd().
2. Creating a folder named specdata if it does not exist.
3. Downloading the zipped file and naming it "UCI_HAR_Dataset.zip", storing it in "specdata".
4. Unzipping the file and putting it in the folder "UCI HAR Dataset".
5. Loading and reading the data stored in the unzipped file (Y_test, Y_train, subject_train,
subject_test, X_test, X_train) and naming it accordingly.

Step 1: Merges the training and the test sets to create one data set.
1. Row bind the subject_test and subject_train into a single data set named "Subject".
2. Row bind the Y_test and Y_train into a single data set named "Activity".
3. Row bind the X_test and X_train into a single data set named "Features".
4. Setting names to variables.
5. Reading features names stored in "features.txt".
5. Column bind Subject and Activity into a single data set named "Combine".
6. Column bind Features and Combine into a single data set named "Data".

Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
1. Getting only the measurements  of the mean and standard deviation based on the FeaturesNames.
2. Subsetting the data frame "Data" by selected names from the vector created named "selectedNames".

Step 3: Uses descriptive activity names to name the activities in the dataset.
1. Reading descriptive activity names from “activity_labels.txt”.
2. As identified from activity_labels.txt, rename the numerical labels by the corresponding descriptive labels.
    1 replaced to WALKING
    2 replaced to WALKING_UPSTAIRS
    3 replaced to WALKING_DOWNSTAIRS
    4 replaced to SITTING
    5 replaced to STANDING
    6 replaced to LAYING

Step 4: Appropriately labels the data set with descriptive variable names.
1.Names of Features will be labeled using descriptive variable names.
    "^t" is replaced by Time
    "Acc" is replaced by "Accelerometer"
    "Gyro" is replaced by "Gyroscope"
    "^f" is replaced by Frequency
    "Mag" is replaced by "Magnitude"
    "BodyBody" is replaced by "Body"

Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
1. Using the aggregate() function to group the data set by activities and subject and taking the mean of each group.
2. Sorting the mean of each group.
3. Using the write.table() function, create a text file called "TidyData" that contains the final tidy data set.
