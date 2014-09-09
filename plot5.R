#Download the file from the site given
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", method="curl", destfile="FNEI_data.zip")

#unzip the file and save it in data directory.
unzip("FNEI_data.zip", exdir="./data")

# Read the data file
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# ON-ROAD could mean motor vehicles
BaltimoreCityMV <- subset(NEI, fips == "24510" & type=="ON-ROAD")

png("data/plot5.png")
x <- tapply(BaltimoreCityMV$Emissions, BaltimoreCityMV$year, sum)
plot(names(x), x, type="l", main="Baltimore City Motor Vehicle Emissions by Year", xlab="Year", ylab="Total Emissions", col="red")
dev.off()
