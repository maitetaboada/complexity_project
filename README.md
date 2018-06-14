# complexity_project
General steps, resources and scripts for complexity & subjectivity project
Katharina Ehret and Maite Taboada

This repository contains the following resources: 

1. Argumentation features and SOCALfeatures. These folders contain the lists of argumentation and subjectivity markers used for measuring subjectivity in Ehret & Taboada (in preparation). 

2. Scripts for data generation, clean-up and the retrieval of the subjectivity markers.

General steps of data processing and generation:

1. Subjectivity: The argumentation and subjectivity markers were retrieved from the database using the sub_marker.py script. The script takes a folder containing the csv files with the relevant features. The argumentation features and the SOCAL invariant features were retrieved using the 'False' argument to indicate that those features are invariant. The SOCAL variant features were retrieved using the "True" argument to indicate that those features are variant and need to be retrieved according to their POS-tag. The statistical analysis of subjectivity markers is based on the summed csv output of the script. 

