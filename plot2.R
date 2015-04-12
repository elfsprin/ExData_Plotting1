#get file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="household_power_consumption.txt", method="curl")

#read table
hpc<-read.table("household_power_consumption.txt",header=TRUE,sep=";",
                colClasses=c(rep("character",2),rep("numeric",7)),
                na.strings=c("?"))
#convert Date field to date format
hpc$date<-as.Date(hpc$Date, format = "%d/%m/%Y")

#convert Time field to time format using chron, install chron in case grader
#doesn't have it
install.packages("chron")
library(chron)
hpc$Time<-chron(times=hpc$Time)

#subset out dates of interest
hpcSub<-subset(hpc, hpc$Date == "1/2/2007" | hpc$Date == "2/2/2007")

#add datetime column
library(lubridate)
hpcSub$datetime<-dmy_hms(paste(hpcSub$Date,hpcSub$Time))

#save default par
parDefault<-par

#create line plot of global active power, save to png
png(filename="plot2.png",type=c("quartz"))
        plot(hpcSub$datetime,hpcSub$Global_active_power,xlab="",
                ylab="Global Active Power (kilowatts)",type="l")
dev.off()

#restore default par
par<-parDefault