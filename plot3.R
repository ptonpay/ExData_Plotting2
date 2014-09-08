#Download the file from the site given
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", method="curl", destfile="FNEI_data.zip")

#unzip the file and save it in data directory.
unzip("FNEI_data.zip", exdir="./data")

#Read summary and Source classification as a data frame in NEI and SCC
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# create a data frame for Baltimore only
NEI_baltimore <- NEI[NEI$fip == "24510"]

# find unique types 
unique(NEI_baltimore$type)
# Gives [1] "POINT"    "NONPOINT" "ON-ROAD"  "NON-ROAD"

png("data/plot3.png")

# Draw all 4 plots on the same canvas, so using par function
par(mfrow=c(2,2))

# plot for type=POINT
plot(names(tapply((NEI_baltimore[which(NEI_baltimore$type == "POINT"), ])$Emissions, (NEI_baltimore[which(NEI_baltimore$type == "POINT"), ])$year, sum)),tapply((NEI_baltimore[which(NEI_baltimore$type == "POINT"), ])$Emissions, (NEI_baltimore[which(NEI_baltimore$type == "POINT"), ])$year, sum), type="l", main="Type=POINT", xlab="year", ylab="Sum of Emissions for POINT")

# plot for type=NONPOINT
plot(names(tapply((NEI_baltimore[which(NEI_baltimore$type == "NONPOINT"), ])$Emissions, (NEI_baltimore[which(NEI_baltimore$type == "NONPOINT"), ])$year, sum)),tapply((NEI_baltimore[which(NEI_baltimore$type == "NONPOINT"), ])$Emissions, (NEI_baltimore[which(NEI_baltimore$type == "NONPOINT"), ])$year, sum), type="l", main="Type=NONPOINT", xlab="year", ylab="Sum of Emissions for NONPOINT")

# plot for type=ON-ROAD
plot(names(tapply((NEI_baltimore[which(NEI_baltimore$type == "ON-ROAD"), ])$Emissions, (NEI_baltimore[which(NEI_baltimore$type == "ON-ROAD"), ])$year, sum)),tapply((NEI_baltimore[which(NEI_baltimore$type == "ON-ROAD"), ])$Emissions, (NEI_baltimore[which(NEI_baltimore$type == "ON-ROAD"), ])$year, sum), type="l", main="Type=ON-ROAD", xlab="year", ylab="Sum of Emissions for ON-ROAD")

# plot for type=NON-ROAD
plot(names(tapply((NEI_baltimore[which(NEI_baltimore$type == "NON-ROAD"), ])$Emissions, (NEI_baltimore[which(NEI_baltimore$type == "NON-ROAD"), ])$year, sum)),tapply((NEI_baltimore[which(NEI_baltimore$type == "NON-ROAD"), ])$Emissions, (NEI_baltimore[which(NEI_baltimore$type == "NON-ROAD"), ])$year, sum), type="l", main="Type=NON-ROAD", xlab="year", ylab="Sum of Emissions for NON-ROAD")

dev.off();

#Conclusion
# For type=NON-POINT, ON-ROAD and NON-ROAD there was a decrease in Emissions
# For type=POINT there was a slight increase in emission
