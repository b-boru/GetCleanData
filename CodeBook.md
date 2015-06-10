# CodeBook

This tidy data set contains the union of the original **training** and **test** data sets, from the `train/X_train.txt` and `test/X_test.txt` files.

To each row has been added the id of the test subject (from `train/subject_train.txt` and `test/subject_test.txt`)
and the type of activity (from `train/y_train.txt` and `test/y_test.txt`, using the descriptive names from `activity_labels.txt`).

Also, the columns are named according to the description found in files `features.txt` and `features_info.txt`.

From this dataset, only columns of type **mean()** or **std()** have been kept: this means that the original
variables of types *mad()*, *max()*, *min()*, *sma()*, *energy()*, *iqr()*, *entropy()*, *arCoeff()*, *correlation()*,
*maxInds()*, *meanFreq()*, *skewness()*, *kurtosis()*, *bandsEnergy()*, *angle()*, etc are omitted. The remaining variables
of the tidy data set are thus:
+ activity
+ subject
+ tBodyAcc.mean.XYZ     (meaning in fact the three variables *tBodyAcc.mean.X*, *tBodyAcc.mean.Y* and *tBodyAcc.mean.Z*)
+ tBodyAcc.std.XYZ
+ tGravityAcc.mean.XYZ
+ tGravityAcc.std.XYZ
+ tBodyAccJerk.mean.XYZ
+ tBodyAccJerk.std.XYZ
+ tBodyGyro.mean.XYZ
+ tBodyGyro.std.XYZ
+ tBodyGyroJerk.mean.XYZ
+ tBodyGyroJerk.std.XYZ
+ tBodyAccMag.mean
+ tBodyAccMag.std
+ tGravityAccMag.mean
+ tGravityAccMag.std
+ tBodyAccJerkMag.mean
+ tBodyAccJerkMag.std
+ tBodyGyroMag.mean
+ tBodyGyroMag.std
+ tBodyGyroJerkMag.mean
+ tBodyGyroJerkMag.std
+ fBodyAcc.mean.XYZ
+ fBodyAcc.std.XYZ
+ fBodyAccJerk.mean.XYZ
+ fBodyAccJerk.std.XYZ
+ fBodyGyro.mean.XYZ
+ fBodyGyro.std.XYZ
+ fBodyAccMag.mean
+ fBodyAccMag.std
+ fBodyBodyAccJerkMag.mean
+ fBodyBodyAccJerkMag.std
+ fBodyBodyGyroMag.mean
+ fBodyBodyGyroMag.std
+ fBodyBodyGyroJerkMag.mean
+ fBodyBodyGyroJerkMag.std

They correspond to the like-named features (e.g. *tBodyAcc-mean()-X*) from the original data set, with
minor typographical changes. See the original file `features_info.txt` for more info about the variables.

Also, the tidy data set contains only the mean of each variable, for each test subject and for each activity.
This means it contains 30 (number of test subjects) * 6 (number of activities) rows, indexed by activity
and test subject, each containing the mean of the 66 remaining variables.

