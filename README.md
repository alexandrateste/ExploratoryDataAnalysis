## Project Description and Questions
For this project, I used the provided data stemming from the National Emissions Inventory, which records the number of tons of PM2.5 emitted from a variety of sources over the course of an entire year. The data used for this assignment actually spanned the years 1999, 2002, 2005, and 2008.

The codes and plots I provide here were created to answer the 6 following questions:

1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.   --> Yes

2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.    --> Overall yes, but there was an increase in 2005

3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.  --> Non-point, Non-road and On-road

4. Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?    --> They have overall decreased

5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?      --> They have decreased (cf. "Explanations" section below)

6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?      --> Given the data I chose to conduct this analysis, emissions in Los Angeles were a lot higher than those in Baltimore. It was then not straightforward to see with certainty which city saw the biggest changes in PM2.5 emissions. This is why I plotted not only absolute emissions but also percentage differences over 3 years. From this plot, my answer to the question is Baltimore (as shown on the Percentage Difference graph).

## Explanation for the data considered as related to motor vehicles

According to wikipedia:

> "A motor vehicle or road vehicle is a self-propelled wheeled vehicle that does not operate on rails, such as trains or trolleys. The vehicle propulsion is provided by an engine or motor, usually by an internal combustion engine, or an electric motor, or some combination of the two, such as hybrid electric vehicles and plug-in hybrids. For legal purposes motor vehicles are often identified within a number of vehicle classes including cars, buses, motorcycles off-road vehicles, light trucks and regular trucks."

Additionally, as we are asked to compare 2 urban areas, I am considering only vehicles which purpose is the transport of people or freit, on regular road and highways. I am consequently excluding any other mode of transportation (airplanes, marine vessels, trains, golf cart, tractors, etc.) or machines powered by motors (lawn mower, pumps, refrigerators, etc.)
This means:

* all rows with Data.Category = "Onroad"
* all rows with Data.Category="Nonroad" and Short.Name that contains "motorcycles"

*Note: For Data.Category = "Nonpoint", I looked at EI.Sector ="Mobile - On-Road Gasoline Light Duty Vehicles" and "Mobile - Non-Road Equipment - Other", but they correspond to border crossing or non-US sources, which is not relevant here.*

*For Data.Category = "Point", I looked at EI.Sector="Mobile - Non-Road Equipment - Gasoline", "Mobile - Non-Road Equipment - Diesel" and "Mobile - Non-Road Equipment - Other", but most of them corresponded to a Short.Name related to "Airport Ground Support Equipment" or "Industrial Fork Lift". So, I ignored these data rows.*
