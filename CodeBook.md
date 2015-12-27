# Code Book for courseraGetDataProject

## Variables

The variable names used below are derived from those used
in the original project by (a) dropping potentially confusing
character sequences such as '()' and (b) disambiguating 
duplicated feature names by adding single character suffixes
('A', 'B', and "C') where necessary.  The considerations 
behind the selection of names is set out in 
UCI HAR Dataset/features_info.txt and there is a comprehensive list of 
the 561 feature names in UCI HAR Dataset/features.txt.

<table>
<tr><th>feature</th><th>units</th><th>description</th></tr>

<tr><td>activity</td><td>N/A</td><td>name of activity</td></tr>
<tr><td>subject</td><td>N/A</td><td>subject ID (int)</td></tr>

<tr><td>tBodyAcc_mean_X</td><td>g</td><td>YYY</td></tr>
<tr><td>tBodyAcc_mean_Y</td><td>g</td><td>YYY</td></tr>
<tr><td>tBodyAcc_mean_Z</td><td>g</td><td>YYY</td></tr>
<tr><td>tGravityAcc_mean_X</td><td>g</td><td>YYY</td></tr>
<tr><td>tGravityAcc_mean_Y</td><td>g</td><td>YYY</td></tr>
<tr><td>tGravityAcc_mean_Z</td><td>g</td><td>YYY</td></tr>

<tr><td>tBodyAccJerk_mean_X</td><td>g</td><td>YYY</td></tr>
<tr><td>tBodyAccJerk_mean_Y</td><td>g</td><td>YYY</td></tr>
<tr><td>tBodyAccJerk_mean_Z</td><td>g</td><td>YYY</td></tr>

<tr><td>tBodyGyro_mean_X</td><tdr/s^2/td><td>YYY</td></tr>
<tr><td>tBodyGyro_mean_Y</td><tdr/s^2/td><td>YYY</td></tr>
<tr><td>tBodyGyro_mean_Z</td><tdr/s^2/td><td>YYY</td></tr>
<tr><td>tBodyGyroJerk_mean_X</td><tdr/s^2/td><td>YYY</td></tr>
<tr><td>tBodyGyroJerk_mean_Y</td><tdr/s^2/td><td>YYY</td></tr>
<tr><td>tBodyGyroJerk_mean_Z</td><tdr/s^2/td><td>YYY</td></tr>

<tr><td>tBodyAccMag_mean</td><td>g</td><td>YYY</td></tr>
<tr><td>tGravityAccMag_mean</td><td>g</td><td>YYY</td></tr>
<tr><td>tBodyAccJerkMag_mean</td><td>g</td><td>YYY</td></tr>

<tr><td>tBodyGyroMag_mean</td><td>r/s^2</td><td>YYY</td></tr>
<tr><td>tBodyGyroJerkMag_mean</td><td>r/s^2</td><td>YYY</td></tr>

<tr><td>fBodyAcc_mean_X</td><td>g</td><td>YYY</td></tr>
<tr><td>fBodyAcc_mean_Y</td><td>g</td><td>YYY</td></tr>
<tr><td>fBodyAcc_mean_Z</td><td>g</td><td>YYY</td></tr>

<tr><td>fBodyAcc_meanFreq_X</td><td>g</td><td>YYY</td></tr>
<tr><td>fBodyAcc_meanFreq_Y</td><td>g</td><td>YYY</td></tr>
<tr><td>fBodyAcc_meanFreq_Z</td><td>g</td><td>YYY</td></tr>
<tr><td>fBodyAccJerk_mean_X</td><td>g</td><td>YYY</td></tr>
<tr><td>fBodyAccJerk_mean_Y</td><td>g</td><td>YYY</td></tr>
<tr><td>fBodyAccJerk_mean_Z</td><td>g</td><td>YYY</td></tr>
<tr><td>fBodyAccJerk_meanFreq_X</td><td>g</td><td>YYY</td></tr>
<tr><td>fBodyAccJerk_meanFreq_Y</td><td>g</td><td>YYY</td></tr>
<tr><td>fBodyAccJerk_meanFreq_Z</td><td>g</td><td>YYY</td></tr>

<tr><td>fBodyGyro_mean_X</td><td>r/s^2</td><td>YYY</td></tr>
<tr><td>fBodyGyro_mean_Y</td><td>r/s^2</td><td>YYY</td></tr>
<tr><td>fBodyGyro_mean_Z</td><td>r/s^2</td><td>YYY</td></tr>
<tr><td>fBodyGyro_meanFreq_X</td><td>r/s^2</td><td>YYY</td></tr>
<tr><td>fBodyGyro_meanFreq_Y</td><td>r/s^2</td><td>YYY</td></tr>
<tr><td>fBodyGyro_meanFreq_Z</td><td>r/s^2</td><td>YYY</td></tr>

<tr><td>fBodyAccMag_mean</td><td>g</td><td>YYY</td></tr>
<tr><td>fBodyAccMag_meanFreq</td><td>g</td><td>YYY</td></tr>
<tr><td>fBodyBodyAccJerkMag_mean</td><td>g</td><td>YYY</td></tr>
<tr><td>fBodyBodyAccJerkMag_meanFreq</td><td>g</td><td>YYY</td></tr>

<tr><td>fBodyBodyGyroMag_mean</td><td>r/s^2</td><td>YYY</td></tr>
<tr><td>fBodyBodyGyroMag_meanFreq</td><td>r/s^2</td><td>YYY</td></tr>
<tr><td>fBodyBodyGyroJerkMag_mean</td><td>r/s^2</td><td>YYY</td></tr>
<tr><td>fBodyBodyGyroJerkMag_meanFreq</td><td>r/s^2</td><td>YYY</td></tr>

<tr><td>tBodyAcc_std_X</td><td>sigma</td><td>YYY</td></tr>
<tr><td>tBodyAcc_std_Y</td><td>sigma</td><td>YYY</td></tr>
<tr><td>tBodyAcc_std_Z</td><td>sigma</td><td>YYY</td></tr>
<tr><td>tGravityAcc_std_X</td><td>sigma</td><td>YYY</td></tr>
<tr><td>tGravityAcc_std_Y</td><td>sigma</td><td>YYY</td></tr>
<tr><td>tGravityAcc_std_Z</td><td>sigma</td><td>YYY</td></tr>
<tr><td>tBodyAccJerk_std_X</td><td>sigma</td><td>YYY</td></tr>
<tr><td>tBodyAccJerk_std_Y</td><td>sigma</td><td>YYY</td></tr>
<tr><td>tBodyAccJerk_std_Z</td><td>sigma</td><td>YYY</td></tr>
<tr><td>tBodyGyro_std_X</td><td>sigma</td><td>YYY</td></tr>
<tr><td>tBodyGyro_std_Y</td><td>sigma</td><td>YYY</td></tr>
<tr><td>tBodyGyro_std_Z</td><td>sigma</td><td>YYY</td></tr>
<tr><td>tBodyGyroJerk_std_X</td><td>sigma</td><td>YYY</td></tr>
<tr><td>tBodyGyroJerk_std_Y</td><td>sigma</td><td>YYY</td></tr>
<tr><td>tBodyGyroJerk_std_Z</td><td>sigma</td><td>YYY</td></tr>
<tr><td>tBodyAccMag_std</td><td>sigma</td><td>YYY</td></tr>
<tr><td>tGravityAccMag_std</td><td>sigma</td><td>YYY</td></tr>
<tr><td>tBodyAccJerkMag_std</td><td>sigma</td><td>YYY</td></tr>
<tr><td>tBodyGyroMag_std</td><td>sigma</td><td>YYY</td></tr>
<tr><td>tBodyGyroJerkMag_std</td><td>sigma</td><td>YYY</td></tr>
<tr><td>fBodyAcc_std_X</td><td>sigma</td><td>YYY</td></tr>
<tr><td>fBodyAcc_std_Y</td><td>sigma</td><td>YYY</td></tr>
<tr><td>fBodyAcc_std_Z</td><td>sigma</td><td>YYY</td></tr>
<tr><td>fBodyAccJerk_std_X</td><td>sigma</td><td>YYY</td></tr>
<tr><td>fBodyAccJerk_std_Y</td><td>sigma</td><td>YYY</td></tr>
<tr><td>fBodyAccJerk_std_Z</td><td>sigma</td><td>YYY</td></tr>
<tr><td>fBodyGyro_std_X</td><td>sigma</td><td>YYY</td></tr>
<tr><td>fBodyGyro_std_Y</td><td>sigma</td><td>YYY</td></tr>
<tr><td>fBodyGyro_std_Z</td><td>sigma</td><td>YYY</td></tr>
<tr><td>fBodyAccMag_std</td><td>sigma</td><td>YYY</td></tr>
<tr><td>fBodyBodyAccJerkMag_std</td><td>sigma</td><td>YYY</td></tr>
<tr><td>fBodyBodyGyroMag_std</td><td>sigma</td><td>YYY</td></tr>
<tr><td>fBodyBodyGyroJerkMag_std</td><td>sigma</td><td>YYY</td></tr>
</table>

### Time-domain Variables and FFT Results

In the table above, 

* Features whose name begins with the letter 't' are time-domain variables.
* Features whose name begins with the letter 'f' are derived from 
  the time-domain variables by Fast Fourier Transforms.

### Units

* Acceleration is measured in **g**s, where g is the standard acceleration 
  of gravity, 9.80665 meters per second per second.
* Angular acceleration is measured in **radians per second per second**,
  written as rad/s^2
* Features whose name include `std` represent standard deviations and are
  measured in **sigma**, the square root of the variance of 
  a variable; roughly 68.2% of observations are expected to fall within 
  one sigma of the mean.

### Dimensions

In the table above, 3D measurements are either cartesian or radial.  In both
cases X, Y, and Z represent the first, second, or third dimension.

## Dataset

The output of the project is a single tidy dataset, `tidyData5` in the main
project directory.  This contains 180 observations of 81 variables grouped
by activity ("SITTING", "LAYING", "WALKING", etc) and by subject ID.

## Transformations

See README.md
