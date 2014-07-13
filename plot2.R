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
png('plot2.png',bg = 'transparent')

#COnstruct the plot
plot(data$Time, data$Global_active_power, xlab='', ylab = 'Global Active Power (Kilowatts)', type = 'l')

#Close the device
dev.off()

######  Very Important ######
### please notice that I'm using a French version of R.
### So, the days in the plots are in French : <jeu> stands for <Thu>, 
### <ven> stands for <Fri> and <sam> stands for <Sat>.
