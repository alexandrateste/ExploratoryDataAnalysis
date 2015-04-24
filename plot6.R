library(plyr)
library(dplyr)
library(ggplot2)

# Data retrieval
NEI <- readRDS("summarySCC_PM25.rds")
SCCTable <- readRDS("Source_Classification_Code.rds")

# Data extraction for Baltimore and Los Angeles
twocities<-subset(NEI, fips %in% c('24510','06037'))

# !!! 'Motor vehicles' are considered here as on the road vehicle sources
motorveh_codes <- SCCTable[(grepl('Veh', SCCTable$Short.Name, ignore.case = TRUE)) & 
                                   (grepl('Onroad', SCCTable$Data.Category, ignore.case = TRUE)),1]

# !! 'motorveh_codes' is a vector of factors
# Transformation of the SCC column of the 'twocities' table into factors
# to allow for proper comparison with motorveh_codes
twocities$SCC <- as.factor(twocities$SCC)

# Extraction of Baltimore and Los Angeles data for onroad motor vehicles only
motorvehicle_emissions <- subset(twocities, SCC %in% motorveh_codes)

# Renaming of the 'fips' values: 24510 replaced by Baltimore and 06037 by Los Angeles
motorvehicle_emissions$City <- revalue(motorvehicle_emissions$fips,
                                       c("24510"="Baltimore", "06037"="Los Angeles"))

# Transformation of 'City' into a factor vector (for better plot legend display)
motorvehicle_emissions$City <- as.factor(motorvehicle_emissions$City)


detach(package:plyr)
# Grouping both by City and by year
groups <-motorvehicle_emissions %.% regroup(list(quote(year), quote(City))) %.% summarise(PM25_Emissions=sum(Emissions, na.rm=TRUE))
# Sorting of results by City
sorted_groups<-groups[with(groups, order(City)), ]

#Extraction of all total PM2.5 emissions values
# And construction of the data frame (final_df)
# That will contain the percentage differences
# Over 3 years, for each city
PMEm<-c(sorted_groups$PM25_Emissions)
pct_dff<-vector()
rrange = c(2,3,4,6,7,8)
for (k in 2:4){
        pct_dff[k-1] <- 100.*(PMEm[k]-PMEm[k-1])/PMEm[k-1]
        # provides pct_dff[1 through 3]
}
for (k in 6:8){
        pct_dff[k-2] <- 100.*(PMEm[k]-PMEm[k-1])/PMEm[k-1]
        # provides pct_dff[4 through 6]
}

final_df <- data.frame(Intervals = c("1999-2002","2002-2005","2005-2008"),
                       City=c(rep("Baltimore",3),rep("Los Angeles",3)),
                       Percent_Diff=pct_dff)

install.packages("gridExtra")
library(grid)
library(gridExtra)

# Plotting of the graphs
png(filename = "plot6.png", width = 640, height = 480, units = "px")
p1 <- ggplot(motorvehicle_emissions, aes(factor(year), Emissions))+
        stat_summary(fun.y = sum, geom = "bar", position="dodge")+
        aes(fill = City)+
        labs(y="Total PM2.5 Emissions (tons)",x="Years", 
             title="Total PM2.5 Emissions") +  theme(legend.position="bottom")
p2 <- ggplot(final_df, aes(factor(Intervals), Percent_Diff))+
        geom_bar(stat="identity", position="dodge")+
        aes(fill = City)+
        labs(y="% difference from beginning of intervals",x="Years", 
             title="Percent Difference") +  theme(legend.position="bottom")

grid.arrange(p1, p2, ncol = 2, main = "Evolution of Absolute Values and Percentage Difference in PM2.5 Emissions\nFrom Motor Vehicles in Baltimore and Los Angeles from 1999 to 2008")
dev.off()
