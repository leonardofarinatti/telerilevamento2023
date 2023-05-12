# R code downloading and visualizing Copernicus data

library(raster)
library(ncdf4)
library(ggplot2)
library(viridis)
setwd("C:/Lab/")
# dataset: c_gls_SSM1km_202305090000_CEURO_S1CSAR_V1.2.1.nc

sc <- raster("c_gls_SSM1km_202305090000_CEURO_S1CSAR_V1.2.1.nc")
plot(sc)
scd <- as.data.frame(sc, xy=T)
ggplot() +
geom_raster(scd, mapping=aes(x=x, y=y, fill=Surface.Soil.Moisture)) +
ggtitle("Soil Moisture for Copernicus")
