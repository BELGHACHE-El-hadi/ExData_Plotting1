## Read the specefic lines from the file 
data<-read.table(file='household_power_consumption.txt', header=F,sep=';', na.strings='?', quote="", skip=66637, nrows=(69516-66637+1))

## Name the columns of data from the file
ColNames<-names(read.table(file='household_power_consumption.txt', header=T,sep=';', na.strings='?', quote="", nrows=1))
names(data)<-ColNames


## Convert the column 'Date' into Date Class
data[,'Date']<-as.Date(data[,'Date'], format='%d/%m/%Y')

## Convert the column 'Time' into Time Class
time<-data$Time
data$Time<-NA
for(i in 1:nrow(data))
      data[i,'Time']<-paste(as.character(data[i,'Date']),as.character(time[i]))

time<-data$Time
data$Time<-NULL
data$Time<-strptime(time, format='%F %T')



## Start the plot
#Lunch de PNF device
png('plot4.png',bg = 'transparent')

#COnstruct the plot
par(mfrow = c( 2, 2))
with(airquality, { 
      # Plot 1
      plot(data$Time, data$Global_active_power, xlab='', ylab = 'Global Active Power', type = 'l')
      
      # Plot 2
      plot(data$Time, data$Voltage, xlab='datetime', ylab = 'Voltage', type = 'l')
      
      # Plot 3
      with(data, plot(Time, Sub_metering_1, type='l',xlab='' ,ylab = 'Energy sub metering'))
      
      with(data, lines(Time, Sub_metering_2, col = "red"))
      
      with(data, lines(Time, Sub_metering_3, col = "blue"))
      
      legend("topright", box.lty = 0,lwd = 1, seg.len = 1, col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
      
      # Plot 4
      plot(data$Time, data$Global_reactive_power, xlab='datetime', ylab = 'Global_reactive_power', type = 'l')
      })

#Close the device
dev.off()

###### Very Important ######
### please notice that I'm using a French version of R.
### So, the days in the plots are in French : <jeu> stands for <Thu>, 
### <ven> stands for <Fri> and <sam> stands for <Sat>.
