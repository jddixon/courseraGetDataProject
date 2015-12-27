# courseraGetDataProject

This is my course project for the Johns Hopkins/Coursera GetData 
course, part of their Data Science specialization.  All of the material
discussed here is open source and available through 
[github](https://jddixon.github.com/courseraGetDataProject).  On most Linux 
and other POSIX-compliant machines it can be downloaded using

    git clone https://jddixon.github.com/courseraGetDataProject

after changing to a suitable directory.

## Original Data

This project focuses on extracting a tidy dataset from the "Human Activity
Recognition Using Smartphones" project at the University of Genoa, Italy.
The data from Genoa was supplied as a tarball 
`getdata_projectfiles_UCI Dataset.zip`.  This tarball is included in the 
material on this project's github site.  Unzipping the tarball produced
the `UCI HAR Dataset` subdirectory.

That subdirectory contains at the top level

* activity_labels.txt, the six labels applied to test sessions
* features_info.txt, 
* features.txt
* README.txt and two subdirectories:
* test/ and
* train/

The test/ and train/ subdirectories are identically structured.  The
original project data was randomly split between test (30%) and training
data (70%).  

Each of the two subdirectories contains an Inertial Signals 
(sub-)subdirectory which contains nine files:

* three body acceleration files, one each for the X, Y, and Z dimensions;
  these are adjusted to correct for the local acceleration of gravity
* three uncorrected total acceleration files, one each for X, Y, and Z
* three gyroscopic acceleration files, one for each of the three radial
  dimensionts, labeled X, Y, and Z

Each of these files contains raw or close to raw data.  The files in the
test/Inertial Signals subdirectory consist of 2947 rows of 128 values each, 
where each value is serialized as a 16-character field.  The equivalent
train/ files contain 7352 rows.

The data in the containing directories (test/ and train/) consists
of two files derived from actual observation (subject ID and activity
index) and a third, containing rows of 561 values calculated from 
the inertial data.  For test/ these are

* subject_test.txt,
* y_test.txt, and
* X_test.txt

The files in test/ have 2947 rows each; the corresponing files in train/
have 7352 rows each.  The data of interest to our project 
(CourseraGetDataProject) is largely in the X_test.txt and X_train.txt files.

## Transforming the Data

The first requirement is to merge the two datasets, the test/ and train/
datasets.  This is made a little complicated by fact that the `merge`
function does not guarantee that order be preserved.  So after reading
the corresponding data files from each of test/ and train/, they are
passed to a special function, mergePreservingOrder().  This adds a 
column of rowIDs to each of the tables to be merged, then does the
merge sorting on the rowIDs, then removes the rowIDs before returning
the newly merged result.

All of the relevant data files in the two data sets are merged using
this function.

The second step is to extract the mean and standard deviation 
measurements from the merged X results (mergedDataX).  This is most easily 
done after adding the column names found in the features.txt file.  However,
there are problems: first, the feature names include character sequences
such as '()' which could cause confusion; secondly, feature names are
not unique (!).  In fact there are some nine sequences of 14 features
each (three sets of three) which share feature names.  To deal with 
these problems, the problem characters are removed and the duplicate
name sequences are disambiguated in the function `fixFeatures()`.  Once
this is done the improved features list becomes the column names 
for mergedDataX and then a `simplerData` data frame is created from 
mergedDataX by using dplyr's `select` function to extract column
names containing 'mean' and 'std'.

Assigning meaningful column names in this step also meets the fourth
requirement, descriptive column names.

The third step makes this a truly tidy data set by adding subject and activity
columns.  The subject column is simply the vector of subject IDs from
the mergedSubjects data frame.  The activity column is created by using 
`plyr::mapvalues()` to convert the vector of activity indexes in 
the `mergedY` dataframe into a vector of activity labels ('SITTING',
'WALKING', etc) which then becomes another column in the `simplerData`
data frame.

The fifth requirement is met by grouping the simplerDataSet by 
activity and subjectID, and then using dplyr's summarize_each()
function to collapse the other columns, replacing each with its mean.
This is written to disk using write.table as `tidyData5.txt`, which
accomplishes the project's primary objective.




