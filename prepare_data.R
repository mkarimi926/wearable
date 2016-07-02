# prepare_data
# This script loads, prepares and cleans data for analysis

prepare_data <- function() {

# load data
        features <- read.table(file = "UCI HAR Dataset/features.txt", sep = " ")
        print(c("features loaded: nrow=", nrow(features), "ncol", ncol(features)))
        act_labels <- read.table(file = "UCI HAR Dataset/activity_labels.txt", sep = " ")
        print(c("activity loaded: nrow=", nrow(act_labels), "ncol", ncol(act_labels)))
        
        y_test <- read.table(file = "UCI HAR Dataset/test/y_test.txt")
        print(c("y_test loaded: nrow=", nrow(y_test), "ncol", ncol(y_test)))
        x_test <- read.table(file = "UCI HAR Dataset/test/X_test.txt")
        print(c("x_test loaded: nrow=", nrow(x_test), "ncol", ncol(x_test)))
        subject_test <- read.table(file = "UCI HAR Dataset/test/subject_test.txt")
        print(c("subject_test : nrow=", nrow(subject_test), "ncol", ncol(subject_test)))
        
        y_train <- read.table(file = "UCI HAR Dataset/train/y_train.txt")
        print(c("y_train loaded: nrow=", nrow(y_train), "ncol", ncol(y_train)))
        x_train <- read.table(file = "UCI HAR Dataset/train/X_train.txt")
        print(c("x_train loaded: nrow=", nrow(x_train), "ncol", ncol(x_train)))
        subject_train <- read.table(file = "UCI HAR Dataset/train/subject_train.txt")
        print(c("subject_train : nrow=", nrow(subject_train), "ncol", ncol(subject_train)))
        
        # we just need mean and std variables for this analysis
        selected_cols <- grep("mean|std", features[,2])
# prepare test data tables
        x_test_selected <- x_test[,selected_cols]
        new_y_test <- merge(y_test, act_labels)
        
        colnames(new_y_test) <- c("activity_id", "activity_name")
        colnames(subject_test) <- c("subject_id")
        
        #prepare name of columns of x_test_selected
        colid <- as.integer(gsub("V", "", names(x_test_selected)))
        col_names <- features[colid,2]
        colnames(x_test_selected) <- col_names
        
        # bind columns of the tables
        test_data <- cbind(new_y_test, subject_test, x_test_selected)

# prepare training data tables
        x_train_selected <- x_train[,selected_cols]
        new_y_train <- merge(y_train, act_labels)
        
        colnames(new_y_train) <- c("activity_id", "activity_name")
        colnames(subject_train) <- c("subject_id")
        
        #prepare name of columns of x_train_selected
        colid <- as.integer(gsub("V", "", names(x_train_selected)))
        col_names <- features[colid,2]
        colnames(x_train_selected) <- col_names
        
        # bind columns of the tables
        train_data <- cbind(new_y_train, subject_train, x_train_selected)
        
        
# merge test and training data tables
        wearable_data <- rbind(test_data, train_data)
        print("wearable data prepared")
        wearable_data
}