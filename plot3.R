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

#create line plot of Sub_metering fields with legend, save to png
png(filename="plot3.png",type=c("quartz"))
        plot(hpcSub$datetime,hpcSub$Sub_metering_1,xlab="",ylab=
                "Energy sub metering",type="l")
        points(hpcSub$datetime,hpcSub$Sub_metering_2,col="red",type="l")
        points(hpcSub$datetime,hpcSub$Sub_metering_3,col="blue",type="l")
        legend("topright", col = c("black", "red", "blue"), legend = c(
                "Sub_metering_1","Sub_metering_2","Sub_metering_3"),lwd=2,
                lty=c(1,1,1))
dev.off()

#restore default par
par<-parDefault