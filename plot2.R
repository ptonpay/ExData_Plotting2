#Download the file from the site given
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", method="curl", destfile="FNEI_data.zip")

#unzip the file and save it in data directory.
unzip("FNEI_data.zip", exdir="./data")

#Read summary and Source classification as a data frame in NEI and SCC
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

#extact data only for Baltimore city, Maryland in variable called NEI_BCM
NEI_BCM<- NEI[which(NEI$fips==24510),]

#Extract year from NEI variable
sumsWithYearForBCM <- tapply(NEI_BCM$Emissions, NEI_BCM$year, sum)
years <- names(sumsWithYearForBCM)

#Draw the plot with X axis as the year and y axis as the sum of emissions
png("data/plot2.png")
plot(years,sumsWithYearForBCM, type="l", main="Total US PM2.5 Emissions by year", xlab="year", ylab="PM2.5 Emissions Total")
dev.off();

#Results indicate that the total emissions has gone down from 1999 to 2008, however there was an increase around 2005, but then it again went down.
