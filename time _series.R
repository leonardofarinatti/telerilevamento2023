# R code for importing and analysing several images

library(raster)
setwd("C:/lab/greenland")
lst_2000 <- raster("lst_2000.tif")
# Exercise: import all the data
lst_2000 <- raster("lst_2000.tif")
lst_2005 <- raster("lst_2005.tif")
lst_2010 <- raster("lst_2010.tif")
lst_2015 <- raster("lst_2015.tif")
# rlist
rlist <- list.files(pattern="lst")
rlist
# lapply
import <- lapply(rlist,raster)
import
TGr <- stack(import)
TGr
plot(TGr)
plotRGB(TGr, 1, 2, 3, stretch="Lin")
plotRGB(TGr, 2, 3, 4, stretch="Lin")
plotRGB(TGr, 4, 3, 2, stretch="Lin")
dift = TGr[[2]] - TGr[[1]]
plot(dift)
# levelplot(TGr)
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
plot(TGr, col=cl)
