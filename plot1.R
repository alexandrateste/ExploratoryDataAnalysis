library(dplyr)

#Data retrieval
NEI <- readRDS("summarySCC_PM25.rds")
SCCTable <- readRDS("Source_Classification_Code.rds")

# Grouping of data by year
yeargroup <- group_by(NEI,year)

# Plotting of the graph
png(filename = "plot1.png", width = 480, height = 480, units = "px")
totalpm25_peryear <- summarize(yeargroup, PM25_Emissions=sum(Emissions, na.rm=TRUE))
barplot(totalpm25_peryear$PM25_Emissions, names.arg=totalpm25_peryear$year,
        main="Evolution of total PM2.5 emissions \nin the US from 1999 to 2008", xlab="Years",
        ylab="Total PM2.5 emissions (tons)", ylim=c(0,1.1*max(unlist(totalpm25_peryear$PM25_Emissions))))
dev.off()
