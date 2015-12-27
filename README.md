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
* train

The test and train subdirectories are identically structured.  The
original project data was randomly split between test (30%) and training
data (70%).  


