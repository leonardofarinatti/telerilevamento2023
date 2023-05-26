# 3D in R
setwd(C:/Lab/dati)

library(raster) #"Geographic Data Analysis and Modeling"
library(rgdal) #"Geospatial Data Abstraction Library"
library(viridis)
library(ggplot2)

# load dsm 2013
dsm_2013 <- raster("2013Elevation_DigitalElevationModel-0.5m.tif")
dsm_2013d <- as.data.frame(dsm_2013, xy=T)
head(dsm_2013d)

ggplot() +
geom_raster(dsm_2013d, mapping=aes(x=x, y=y, fill=X2013Elevation_DigitalElevationModel.0.5m)) +
scale_fill_viridis() +
ggtitle("dsm 2013")

dtm_2013 <- raster("2013Elevation_DigitalTerrainModel-0.5m.tif")
dtm_2013d <- as.data.frame(dtm_2013, xy=T)
head(dtm_2013d)

ggplot() +
geom_raster(dtm_2013d, mapping=aes(x=x, y=y, fill=X2013Elevation_DigitalTerrainModel.0.5m)) +
scale_fill_viridis(option= "magma") +
ggtitle("dtm 2013")

# create CHM 2013 as difference between dsm and dtm
