################################################################################
# Exploratory Data Analysis - Course Project 1 - Plot 1
## Author:      molinerojo
## Date:        2016-03-05
## Description: The purpose of this script is to built the plot #1, following the instructions of the project;
##              more information in the 'README.md' file.
##              Next tasks will be performed:
##                1. DataSet Downloading.
##                2. DataSet Loading.
##                3. DataSet Cleanning.
##                4. Plot Creation.
##                5. Plot Exporting to .png file.
##
# ------------------------------------------------------------------------------
#  Data Set:    Electric power consumption             
## URL:         https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip             
## Description: Measurements of electric power consumption in one household with a one-minute sampling rate over 
##              a period of almost 4 years. Different electrical quantities and some sub-metering values are available. 
##
# ------------------------------------------------------------------------------
# This script was created on the next environment:
## R version:   3.2.3 (2015-12-10) -- "Wooden Christmas-Tree"
## Platform:    x86_64-w64-mingw32/x64 (64-bit)
## RStudio ver.:0.99.491 - � 2009-2015 RStudio, Inc.
##
################################################################################
#
# R-packages needed:
#
#
#
#
##
# ------------------------------------------------------------------------------

# TASK 1. DataSet Downloading

## DownLoading the Data Sets file

    path       <- getwd()
    file       <- "household_power_consumption.zip"
    path_file  <- paste(path,file,sep="/")

    fileURL    <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileURL, destfile=path_file)

## Unzip the Data Sets file
    
    executable <- file.path("C:", "Program Files", "7-Zip", "7z.exe")
    parameters <- "x"
    cmd        <- paste(paste0("\"", executable, "\""), parameters, paste0("\"", path_file, "\""))
    system(cmd)

# ------------------------------------------------------------------------------
# TASK 2. DataSet Loading

## The file was unzipped in the same folder: the working directory
    
    path       <- getwd()
    file_ds           <- file.path(path, "household_power_consumption.txt")
    ds_HousePowerComp <- read.table(file_ds, header=TRUE, sep=";" )

# ------------------------------------------------------------------------------
# TASK 3.DataSet Cleanning

    ## Subsetting the data set, following the instrucctions on the project.
    ##    We will only be using data from the dates 2007-02-01 and 2007-02-02. 
    
    ds_HousePowerComp$DateTime <- paste(ds_HousePowerComp$Date, ds_HousePowerComp$Time)
    ds_HousePowerComp$DateTime <- strptime(ds_HousePowerComp$DateTime, "%d/%m/%Y %H:%M:%S")
    
    ds_Plot <- rbind( subset(ds_HousePowerComp, strptime(DateTime,"%Y-%m-%d") == strptime("2007-02-01", "%Y-%m-%d")),
                      subset(ds_HousePowerComp, strptime(DateTime,"%Y-%m-%d") == strptime("2007-02-02", "%Y-%m-%d")) )
    
    ## Change Factor Variables to Numeric Variables
    
    ds_Plot$Global_active_power   <- as.numeric(as.character(ds_Plot$Global_active_power))
    ds_Plot$Global_reactive_power <- as.numeric(as.character(ds_Plot$Global_reactive_power))
    ds_Plot$Voltage               <- as.numeric(as.character(ds_Plot$Voltage))
    ds_Plot$Global_intensity      <- as.numeric(as.character(ds_Plot$Global_intensity))
    ds_Plot$Sub_metering_1        <- as.numeric(as.character(ds_Plot$Sub_metering_1))
    ds_Plot$Sub_metering_2        <- as.numeric(as.character(ds_Plot$Sub_metering_2))
    ds_Plot$Sub_metering_3        <- as.numeric(as.character(ds_Plot$Sub_metering_3))
    
# ------------------------------------------------------------------------------
# TASK 4. Plot Creation

## Start Device
    png("plot1.png", width = 480, height = 480)
    
## Plot Creation

    hist(ds_Plot$Global_active_power, 
         main="Global Active Power",
         xlab="Global Active Power (kilowatts)", col="red")

# ------------------------------------------------------------------------------
# TASK 5. Plot Exporting to .png file.

## close the Device 
    dev.off()

# ------------------------------------------------------------------------------
# TASK 999. Remove large objects.
    
    rm(ds_HousePowerComp)
    rm(ds_Plot)
