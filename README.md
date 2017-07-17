# Introduction
This repository contains the course project for the Coursera course "Getting and Cleaning data", part of the Data Science specialization. 

# The R script
The run_analysis.R file does:

1. Loads the data.table library
2. Download and unzip the files for the datasets
3. Loads the dataframes of training, test, activities and subject
4. Transform to a factor the test and train lablels
5. Get only the measurements on the mean and standard deviation
6. Filter by results find above
7. Combine the datasets
8. Rename colnames
9. Transform to factor the subject
10. Creates new tidy dataset