# How to measure landscape variability with R

library(raster)
library(RStoolbox) # for image viewing and variability calculation
library(ggplot2) # for ggplot plotting
library(patchwork) # multiframe with ggplot2 graphs
library(viridis)

setwd("C:/lab/")

sen <- brick("sentinel.png")

# band1 = NIR
# band2 = red
# band3 = green

plotRGB(sen, 1, 2, 3, stretch="lin")
plotRGB(sen, 2, 1, 3, stretch="lin")

# standard deviation on the NIR band
nir <- sen[[1]]
mean3 <- focal(nir, matrix(1/9, 3, 3), fun=mean)
plot(mean3)

sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd) 
plot(sd3)
