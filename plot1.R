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
png('plot1.png',bg = 'transparent')

#COnstruct the plot
hist(data$Global_active_power, col='red', main = 'Global Active Power', xlab = 'Global Active Power (Kilowatts)')

#Close the device
dev.off()
