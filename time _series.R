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


# Example 2: NO2 decrease during the lockdown period

library(raster)
setwd("C:/lab/en")
# Importing a file
en_first <- raster("EN_0001.png")
rimp <- lapply(rlist, raster)
cl <- colorRampPalette(c('red','orange','yellow'))(100)
plot(en_first, col=cl)
# Let's import the whole set
rlist <- list.files(pattern="EN")
import <- lapply(rlist, raster)
EN <- stack(import)
plot(EN, col=cl)
par(mfrow=c(1,2))
plot(en_first, col=cl)
plot(en[[1]], col=cl)
# Check
dif_check <- en_first - EN[[1]]
dif_check
plot(dif_check)
# first and last data
par(mfrow=c(1,2))
plot(en[[1]], col=cl)
plot(en[[13]], col=cl)
# let's make the difference
difen =  en[[1]] - en[[13]]
cldif <- colorRampPalette(c('blue','white','red'))(100)
plot(difen, col=cldif)
# plotRGB of three files together
plotRGB(en, r=1, g=7, b=13, stretch="lin")
plotRGB(en, r=1, g=7, b=13, stretch="hist")
