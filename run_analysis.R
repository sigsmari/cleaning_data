library(data.table)

#Read in the variable and activity names
features <- read.table("./UCI HAR Dataset/features.txt",stringsAsFactors = FALSE)
activity_labels <- fread("./UCI HAR Dataset/activity_labels.txt",stringsAsFactors = FALSE)
setnames(activity_labels,colnames(activity_labels),c("Activity_nr","Activity_name"))
setkey(activity_labels,"Activity_nr")

#Read in the data and merge
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt",col.names="Subject")
x_test <- read.table("./UCI HAR Dataset/test/x_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt",col.names="Activity_nr")
DT_test <- data.table(x_test,subject_test,y_test)

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt",col.names="Subject")
x_train <- read.table("./UCI HAR Dataset/train/x_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt",col.names="Activity_nr")
DT_train <- data.table(x_train,subject_train,y_train)
DT <- rbind(DT_test,DT_train)

#Change the column names of the data table into the variable names
setnames(DT,colnames(DT)[1:561],features[,2])

#Find and select the variables that contain mean or std
Col.mean.std <- c(grep("mean()",colnames(DT)),grep("std()",colnames(DT)))
DT <- DT[,j=c(Col.mean.std,562,563),with=FALSE]

#Get the activity name and remove the Activity number
setkey(DT,"Activity_nr")
DT <- DT[activity_labels]
DT[,Activity_nr:=NULL]

#Calculate the mean of the remaining variables and write into a file
write.table(DT[,lapply(.SD,mean),by = c("Subject","Activity_name")],file="tidy_data.txt",row.names=FALSE)
            
