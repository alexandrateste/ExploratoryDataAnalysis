library(dplyr)
library(ggplot2)

# Data retrieval
NEI <- readRDS("summarySCC_PM25.rds")
SCCTable <- readRDS("Source_Classification_Code.rds")

# Extraction of SCC codes corresponding to coal-combustion related sources
# Codes considered here contain BOTH 'coal" and 'comb' (for combustion)
coalcomb_codes<-SCCTable[(grepl('Coal', SCCTable$Short.Name, ignore.case = TRUE)) & 
                         (grepl('Comb', SCCTable$Short.Name, ignore.case = TRUE)),1]

# !! 'coalcomb_codes' is a vector of factors
# Transformation of the SCC column of the NEI table into factors
# to allow for proper comparison with coalcomb_codes
NEI$SCC <- as.factor(NEI$SCC)

# Extraction of NEI data for coal-combustion related sources only
coalcomb_emissions <- subset(NEI, SCC %in% coalcomb_codes)

# Plotting of the graph
png(filename = "plot4.png", width = 480, height = 480, units = "px")
ggplot(coalcomb_emissions, aes(factor(year), Emissions))+
        stat_summary(fun.y = sum, geom = "bar", position="dodge", fill='aquamarine4') +
        labs(y="Total PM2.5 Emissions (tons)",x="Years", 
             title="Evolution of total PM2.5 emissions from coal-combustion\nrelated sources across the US from 1999 to 2008")
dev.off()
