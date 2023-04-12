###### Advanced aquatic ecology grad course
###Code created by Carolina Barbosa: Geospatial plotting example using LAGOS-US - converting df to spatial object

##Pull in data from EDI portal: https://portal.edirepository.org/nis/codeGeneration?packageId=edi.854.1&statisticalFileType=r
#source("LAGOS_EDI.R")

#loading libraries
library(sf)
library(tidyverse)

#??sf

str(dt1)
#EPSG=4326 -> WGS 84 -- WGS84 - World Geodetic System 1984, used in GPS

#convert df to spatial object
LAGOS_WE_sp <- st_as_sf(dt1,
                    coords= c("lake_lon_decdeg", "lake_lat_decdeg"),
                    crs=4326) %>%
  filter(lake_centroidstate %in% c("CA", "UT", "NV",
                                   "WA", "OR", "ID",
                                   "MT", "WY", "CO",
                                   "NM", "AZ")) %>%
  mutate(lagoslakeid=factor(lagoslakeid))

class(LAGOS_WE_sp)

#plot our plot locations
ggplot()+
  geom_sf(data = LAGOS_WE_sp, color="red")+
  ggtitle("Map of Western US lakes locations")

##Using LAGOS package
library(LAGOSUS)
lg <- lagosus_load(modules = c("locus"))

lg_df <- coordinatize(lg$locus$lake_information) #Turns into a df

#convert df to spatial object
LAGOS_WE_sp2 <- coordinatize(
  lg_df,
  latname = "lake_lat_decdeg",
  longname = "lake_lon_decdeg") %>%
  filter(lake_centroidstate %in% c("CA", "UT", "NV",
                                   "WA", "OR", "ID",
                                   "MT", "WY", "CO",
                                   "NM", "AZ")) %>%
  mutate(lagoslakeid=factor(lagoslakeid))

class(LAGOS_WE_sp2)

#plot our plot locations
ggplot()+
  geom_sf(data = LAGOS_WE_sp2, color="red")+
  ggtitle("Map of Western US lakes locations")

#Another way to visualize the location of the data (lakes)
library(mapview)

mapview(LAGOS_WE_sp)
#mapview(LAGOS_WE_sp2)