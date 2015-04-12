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

#create 4 plots, save to png
png(filename="plot4.png",type=c("quartz"))

#edit special par
par(mfrow = c(2, 2))

#create plot (1,1)
plot(hpcSub$datetime,hpcSub$Global_active_power,xlab="",
        ylab="Global Active Power",type="l")

#create plot (1,2)
plot(hpcSub$datetime,hpcSub$Voltage,xlab="datetime",ylab="Voltage",type="l")

#create plot (2,1)
plot(hpcSub$datetime,hpcSub$Sub_metering_1,xlab="",ylab="Energy sub metering",
        type="l")
points(hpcSub$datetime,hpcSub$Sub_metering_2,col="red",type="l")
points(hpcSub$datetime,hpcSub$Sub_metering_3,col="blue",type="l")
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1",
        "Sub_metering_2","Sub_metering_3"),bty="n",lwd=2,lty=c(1,1,1))

#create plot (2,2)
plot(hpcSub$datetime,hpcSub$Global_reactive_power,xlab="datetime",
        ylab="Global_reactive_power",type="l")

dev.off()

#restore default par
par<-parDefault