#!/usr/bin/env Rscript --vanilla
args <- commandArgs(trailingOnly = TRUE)

#Created by Marc Niebel May 2023
#Purpose of this script is to follow one of two paths interrogating 
#raw JSON files obtained from online Stanford HIV database
#Options will all three regions or int

#Required to get to list of technical files together
suppressMessages(library(plyr))

#Stopping if no json folder is specified
if (length(args) < 1){
  stop("I think you forgot to include your JSON folder\n
	Usage: Rscript HIV_resistance_report_online_only.R raw_json_folder")
}

# Raw JSON folder
json_folder <- list.files(args[1],pattern = ".json",full.names = TRUE)

# Check if patient metadata file has been included
json_folder_patient_metadata <- length(list.files(args[1],pattern=".xlsx"))


if(json_folder_patient_metadata==1){
  # Function which will produce a pdf resistance report and log file
  generating_report <- function(input_json){
    sample_id <- basename(input_json)
    temp_sample_id <- gsub("\\..*","",sample_id)
    sample_id <- sub("^[^_]*_([^_]*).*", "\\1", sample_id)
    #Possible suffix
    suffix <- gsub(".*-", "", sample_id)
    #No suffix(V number should be between 7-9 characters long)
    suffix_length <- nchar(suffix)
  
    #Acceptable suffixes for all_regions workflow are:
    #C,R,RC
    if(suffix =="C"|suffix=="R"|suffix=="RC"|suffix=="OR"|(suffix_length >7 & suffix_length<12)){
      rmarkdown::render(
        "/home/mniebel/HIV-1_DR_RJ_Analysis/extraction_of_metadata_from_online_JSON_all_regions.Rmd",
        params = list(input_json=input_json),output_dir=args[1],
        output_file=paste0(sample_id,".pdf"))
    }else if(suffix == "I"){
      rmarkdown::render(
        "/home/mniebel/HIV-1_DR_RJ_Analysis/extraction_of_metadata_from_online_JSON_INT.Rmd",
        params = list(input_json=input_json), output_dir=args[1],
        output_file=paste0(sample_id,".pdf"))
    } else {
      print(paste("Issues were encountered when producing the resistance report for",
                temp_sample_id,"This is probably due to an incorrect naming of fastqs."))
    }
  }
  #Applies the function on all JSON files
  lapply(json_folder,generating_report)
  #Combine log files together
  list_of_csvs <- list.files(args[1], pattern="*technical_log_*",full.names=TRUE)
  csvs_read <- lapply(list_of_csvs,read.csv)
  combined_csvs <- rbind.fill(csvs_read)
  combined_csvs[is.na(combined_csvs)] <- ""
  output_file_name <- paste0(args[1],"/","combined_technical_logs.csv")
  write.csv(combined_csvs,output_file_name,row.names=FALSE)
  unlink(list_of_csvs)
  #Combine drug susceptibilty files together
  list_of_csvs_ds <- list.files(args[1],pattern="*drug_susceptibility_*",full.names=TRUE)
  csvs_read_ds <- lapply(list_of_csvs_ds,read.csv,colClasses="character")
  combined_csvs_ds <- rbind.fill(csvs_read_ds)
  combined_csvs_ds[is.na(combined_csvs_ds)] <- ""
  output_file_name_ds <- paste0(args[1],"/","combined_drug_susceptibilites.csv")
  write.csv(combined_csvs_ds,output_file_name_ds,row.names=FALSE)
  unlink(list_of_csvs_ds)  
} else {
  print("No patient metadata was added")
}

