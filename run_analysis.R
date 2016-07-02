# run_analysis.R
# This Script loads wearing data, cleans and prepares it and then calculates
#       average of data of each variable for each activity and each subject

source("prepare_data.R");
source("create_mean.R");

run_analysis <- function() {
        # prepare data
        w_data <- prepare_data();
        # calculate mean
        wdm <- create_mean(w_data);
        wdm
}

