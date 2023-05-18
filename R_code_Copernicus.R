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

# Cropping an image
ext <- c(23, 30, 62, 68) # define the extention
sc.crop <- crop(sc, ext)

# Excercise: plot via ggplot the cropped image
scd.crop <- as.data.frame(sc.crop, xy=T)
ggplot() +
geom_raster(scd.crop, mapping=aes(x=x, y=y, fill=Surface.Soil.Moisture)) +
ggtitle("Soil Moisture cropped") +
scale_fill_viridis(option="cividis")

# head() mostra solo i primi elementi
# names() mostra il nome di un dataset
# source() per caricare uno script da un file di testo
