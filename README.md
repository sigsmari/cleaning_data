---
title: "README"
output: html_document
---

This document describes the analysis made to the data collected from the accelerometers from the Samsung Galaxy S smartphone which can be found here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

The analysis was done in the following steps

Read in the variable and activity names

Read in the data and merge

Change the column names of the data table into the variable names
  
Find and select the variables that contain mean or std

Get the activity name and remove the Activity number

Calculate the mean of the remaining variables and write into a file

The result is tidy data with the avarage for each movement of each subject for all the variables that are mean or standard deviation.