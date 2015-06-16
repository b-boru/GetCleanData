# get the ZIP data file, if not already done
if (!file.exists("getdata-projectfiles-UCI HAR Dataset.zip")) {
	download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
								destfile = "getdata-projectfiles-UCI HAR Dataset.zip");
}
# unzip the data file, if not already done
if (!dir.exists("UCI HAR Dataset")) {
	unzip("getdata-projectfiles-UCI HAR Dataset.zip")
}

#
# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation for each measurement. 
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive variable names. 
# 5. From the data set in step 4, create a second, independent tidy data set
#	 with the average of each variable for each activity and each subject.
#


# Step 4: Give a descriptive name to the variables.
# Get the list of all features.
# Each line contains the index in the feature vector, followed by the feature name.
featureNames <- read.table("UCI HAR Dataset/features.txt", quote="", colClasses=c("numeric", "character"), comment.char="");
# sort by index (not really necessary as it seems to be already sorted), and keep only
# the column names in a vector
featureNames <- featureNames[order(featureNames[[1]]), 2];

# Step 2: We want only the mean and standard deviation for each measurement. 
# Hence, we will not use the following files, as they contain only the original raw values:
# The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'.
# Every row shows a 128 element vector.
# The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files
# for the Y and Z axis. 
#  "train/Inertial Signals/total_acc_x_train.txt"
#  "train/Inertial Signals/total_acc_y_train.txt"
#	"train/Inertial Signals/total_acc_z_train.txt"
# The body acceleration signal obtained by subtracting the gravity from the total acceleration
#	"train/Inertial Signals/body_acc_x_train.txt"
#	"train/Inertial Signals/body_acc_y_train.txt"
#	"train/Inertial Signals/body_acc_z_train.txt"
# The angular velocity vector measured by the gyroscope for each window sample.
# The units are radians/second.
#	"train/Inertial Signals/body_gyro_x_train.txt";
#	"train/Inertial Signals/body_gyro_y_train.txt";
#	"train/Inertial Signals/body_gyro_z_train.txt";
# idem for the 'test' set

# We will keep only the variables whose name contains "-mean()" or "-std()", but not "-meanFreq()"
validColumns <- grep("-(mean|std)\\(\\)", featureNames);
# remove "()" from the variable names, then change them to proper variable names
featureNames <- make.names(gsub("\\(\\)", "", featureNames), unique = TRUE);
# keep only the name of the valid columns
featureNames <- featureNames[validColumns];


# we are now ready to read and subset the data


# Step 1: merge the training and the test sets, using the description in README.txt.
# Test set is a 561-feature vector with time and frequency domain variables,
# as described in file features_info.txt.
# All the columns real values separated by a variable number of ' '.
testFeatures <- read.table("UCI HAR Dataset/test/X_test.txt", quote="", colClasses="numeric", comment.char="");
# keep only the valid columns
testFeatures <- testFeatures[,validColumns];
# set the column names in the test features
names(testFeatures) <- featureNames;
# Test labels = the activity label (1 to 6 value) for the corresponding entry in the test set.
# There is one 1...6 integer per row: for the moment, keep it numeric value
testFeatures$activity <- read.table("UCI HAR Dataset/test/y_test.txt", quote="", colClasses="numeric", comment.char="")[[1]];
# Each row identifies the subject (1 to 30 value) who performed the activity.
# There is one 1...30 integer per row: don't make it a factor yet
testFeatures$subject <- read.table("UCI HAR Dataset/test/subject_test.txt", quote="", colClasses="numeric", comment.char="")[[1]];

# also load the training set, which uses the same format
trainFeatures <- read.table("UCI HAR Dataset/train/X_train.txt", quote="", colClasses="numeric", comment.char="");
trainFeatures <- trainFeatures[,validColumns];
names(trainFeatures) <- featureNames;
trainFeatures$activity <- read.table("UCI HAR Dataset/train/y_train.txt", quote="", colClasses="numeric", comment.char="")[[1]];
trainFeatures$subject <- read.table("UCI HAR Dataset/train/subject_train.txt", quote="", colClasses="numeric", comment.char="")[[1]];

# merge the train and test sets in one single data frame.
features <- rbind(trainFeatures, testFeatures);

# now that we have the complete data set, change 'subject' from numeric to factor
features$subject <- factor(features$subject);


# Step 3: change the activities to a factor, using descriptive activity names.
# Read the name and value of the activities.
# Each line contains the numerical value for the activity, followed by its name
activities <- read.table("UCI HAR Dataset/activity_labels.txt", quote="", colClasses=c("numeric", "character"), comment.char="");
# make it a factor into the features set
features$activity <- factor(features$activity, levels=activities[[1]], labels=activities[[2]]);


# 5. We want another data frame with the average of each variable,
# for each activity and each subject.
library(reshape2);
# reshape the data so that there is one measure per activity and subject in column 'variable'
meltedFeatures <- melt(features, id=c("activity", "subject"), measure.vars = featureNames);
# tabulate back the melted data from column 'variable' to a data frame, using activity + subject
# as categories. The fun.aggregate function is applied when there is multiple observations for
# each output cell: with this, we got the mean of each original variable, per activity and per subject.
meanFeatures <- dcast(meltedFeatures, activity + subject ~ variable,  fun.aggregate = mean);

# write this data set into a file
write.table(meanFeatures, file="meanFeatures.txt", row.names=FALSE);

