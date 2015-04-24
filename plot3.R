library(dplyr)
library(ggplot2)

# Data retrieval
NEI <- readRDS("summarySCC_PM25.rds")
SCCTable <- readRDS("Source_Classification_Code.rds")

# Data extraction for Baltimore only
baltimore<-filter(NEI,fips=='24510')

# Transformation of the type variable into a factor
# Storage into a new column for better graphic display
baltimore$Source_Type<-as.factor(baltimore$type)

# Plotting of the graph
png(filename = "plot3.png", width = 480, height = 480, units = "px")
ggplot(baltimore, aes(factor(year), Emissions))+
        stat_summary(fun.y = sum, geom = "bar", position="dodge")+
        aes(fill = Source_Type)+
        labs(y="Total PM2.5 Emissions (tons)",x="Years", 
             title="Evolution of Total PM2.5 Emissions in Baltimore\nfor 4 Source Types")
dev.off()
