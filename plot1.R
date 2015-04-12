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

#create histogram of global active power, save to png
png(filename="plot1.png",type=c("quartz"))
hist(hpcSub$Global_active_power,col="red", main=paste("Global Active Power"),
     xlab="Global Active Power (kilowatts)",ylab="Frequency")
dev.off()