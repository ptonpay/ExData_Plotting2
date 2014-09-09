#Download the file from the site given
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", method="curl", destfile="FNEI_data.zip")

#unzip the file and save it in data directory.
unzip("FNEI_data.zip", exdir="./data")

# Read the data file
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# ON-ROAD could mean motor vehicles
BaltimoreCityMV <- subset(NEI, fips == "24510" & type=="ON-ROAD")
LACityMV <- subset(NEI, fips == "06037" & type=="ON-ROAD")

png("data/plot6.png")
bmc <- tapply(BaltimoreCityMV$Emissions, BaltimoreCityMV$year, sum)
lac <- tapply(LACityMV$Emissions, LACityMV$year, sum)

#scale them using the max values
bmc <- bmc/max(bmc);
lac <- lac/max(lac)
plot(names(bmc), bmc, type="l", main="City Motor Vehicle Emissions by Year", xlab="Year", ylab="Total Emissions", col="red")
lines(names(lac), lac, col="blue")
legend("bottomleft", lwd=c(2.5,2.5), col=c("red", "blue"), c("Baltimore", "Los Angeles"))
dev.off()
