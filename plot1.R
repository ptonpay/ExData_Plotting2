#Download the file from the site given
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", method="curl", destfile="FNEI_data.zip")

#unzip the file and save it in data directory.
unzip("FNEI_data.zip", exdir="./data")

#Read summary and Source classification as a data frame in NEI and SCC
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

#Extract year from NEI variable
sumsWithYear <- tapply(NEI$Emissions, NEI$year, sum)
years <- names(sumsWithYear)

#Draw the plot with X axis as the year and y axis as the sum of emissions
png("data/plot1.png")
plot(years,sumsWithYear, type="l", main="Total US PM2.5 Emissions by year", xlab="year", ylab="PM2.5 Emissions Total")
dev.off();
