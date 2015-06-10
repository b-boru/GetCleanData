# GetCleanData

## Course project for Coursera "Getting and Cleaning Data"

This project uses the dataset provided in https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip,
and produces a tidy data subset.

To generate this dataset, just run the `run_analysis.R` script. There is no argument nor parameters.

This script expects to find the original dataset files (e.g. `features.txt`, `test/*`, `train/*`, etc)
in the same directory.

It produces a tidy dataset, and saves it in a file named `meanFeatures.txt`.

The content of this latter file is described in the file `CodeBook.md`.
