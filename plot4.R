#Download the file from the site given
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", method="curl", destfile="FNEI_data.zip")

#unzip the file and save it in data directory.
unzip("FNEI_data.zip", exdir="./data")

#Read summary and Source classification as a data frame in NEI and SCC
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# Extract SCC values which has the word "Coal" or "coal in it.
CoalSCC <- SCC[which ( SCC$EI.Sector %in% unique(SCC[grep("[C,c]oal", SCC$EI.Sector), "EI.Sector"])),]

#Extract only the fields from NEI where SCC value matches
CoalCombustion <- subset(NEI, SCC %in% CoalSCC$SCC)

sumofEmissionsForEachYear <- tapply(CoalCombustion$Emissions, CoalCombustion$year, sum)

png("data/plot4.png")
plot( names(sumofEmissionsForEachYear), sumofEmissionsForEachYear, type="l", col="red", xlab="Year", ylab="Total Emissions", main="Emissions for coal combustion-related sources")
dev.off()
