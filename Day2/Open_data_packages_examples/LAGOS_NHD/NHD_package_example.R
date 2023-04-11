#### Advanced aquatic ecology grad course
### Code created by Carolina Barbosa based on "Plotting with nhdplusTools' examples from David L Blodgett - April 2023

#dataset: https://www.usgs.gov/national-hydrography/national-hydrography-dataset

library(nhdplusTools)
??nhdplusTools

#Plotting a single National Water Information System (NWIS) site id -> https://waterdata.usgs.gov/nwis/inventory  
plot_nhdplus("05428500")

#Adding other watersheds 
plot_nhdplus(list(list("nwissite", "USGS-05428500"),
                  list("huc12pp", "070900020602"))) #looking into the Watershed Boundary Dataset (WBD) for Hydrologic Unit 12 (HU12) subwatersheds

start_point <- sf::st_as_sf(data.frame(x = -89.36, y = 43.09), 
                            coords = c("x", "y"), crs = 4326) #https://epsg.io/4326 

plot_nhdplus(start_point)

library(sf)
library(dataRetrieval) #https://cran.r-project.org/web/packages/dataRetrieval/vignettes/dataRetrieval.html 

# Now we can use these IDs with dataRetrieval.
par_codes <- readNWISpCode("all")

phosCds <- par_codes[grep("phosphorus",
                      par_codes$parameter_nm,
                      ignore.case=TRUE),]

names(phosCds)
unique(phosCds$parameter_units)

#Example: siteID, parameter code,time frame
siteNo <- "05428500"
pCode <- "00060" #discharge
start.date <- "2017-10-01"
end.date <- "2018-09-30"

yahara <- readNWISuv(siteNumbers = siteNo,
                       parameterCd = pCode,
                       startDate = start.date,
                       endDate = end.date)

yahara <- renameNWISColumns(yahara)
names(yahara)

library(ggplot2)

parameterInfo <- attr(yahara, "variableInfo")
siteInfo <- attr(yahara, "siteInfo")

ggplot(data = yahara,
             aes(dateTime, Flow_Inst)) +
  geom_line() +
  xlab("") +
  ylab(parameterInfo$variableDescription) +
  ggtitle("Yahara River, WI")


?readNWISdata
?readNWISuv
