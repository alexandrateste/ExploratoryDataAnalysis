library(dplyr)
library(ggplot2)

# Data retrieval
NEI <- readRDS("summarySCC_PM25.rds")
SCCTable <- readRDS("Source_Classification_Code.rds")

# Data extraction for Baltimore only
baltimore<-filter(NEI,fips=='24510')

# !!! 'Motor vehicles' are considered here as:
# on the road vehicle sources --> Data.Category = "Onroad"
# or motocycles --> Data.Category="Nonroad" and Short.Name contains "Motorcycles"
# cf. README file for more details
motorveh_codes <- SCCTable[((grepl('Motorcycles', SCCTable$Short.Name, ignore.case = TRUE)) & 
                        (grepl('Nonroad', SCCTable$Data.Category))) | 
                        (grepl('Onroad', SCCTable$Data.Category)),1]


# !! 'motorveh_codes' is a vector of factors
# Transformation of the SCC column of the 'baltimore' table into factors
# to allow for proper comparison with motorveh_codes
baltimore$SCC <- as.factor(baltimore$SCC)

# Extraction of Baltimore data for onroad motor vehicles only
motorvehicle_emissions <- subset(baltimore, SCC %in% motorveh_codes)

# Plotting of the graph
png(filename = "plot5.png", width = 480, height = 480, units = "px")
ggplot(motorvehicle_emissions, aes(factor(year), Emissions))+
        stat_summary(fun.y = sum, geom = "bar", position="dodge", fill='aquamarine4') +
        labs(y="Total PM2.5 Emissions (tons)",x="Years", 
     title="Evolution of Total PM2.5 Emissions from motor vehicles\nin Baltimore and Los Angeles from 1999 to 2008")
dev.off()