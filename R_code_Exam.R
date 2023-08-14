# This is the code for my Telerilevamento Geo-Ecologico exam
# This code will focus to the loss of snow of the Taku glacier, in Alaska

# The code will show the following ponits:
# 1. pca calculation (principal component analysis)
# 2. loss of snow cover calculation
# 3. standard deviation calculation to show the most changed points

# We need to download and call the packages that we will use later
# install.packages ("raster")
library (raster)
# install.packages ("rasterVis")
library (rasterVis)
# install.packages ("ggplot2") # to plot with ggplot
library (ggplot2)
# install.packages ("gridExtra") # to plot the ggplots together
library (gridExtra)

# Now set the working directory
setwd ("C:/lab/Esame")

# We can call our objects, for this code we need two images of two different years (2014 - 2019) of Taku glacier
# Assign to those images a name
taku_2014 <- brick("takuglacierretreat_oli_2014232_lrg.jpg")
taku_2019 <- brick("takuglacierretreat_oli_2019221_lrg.jpg")

# Call them to see the imformation inside

taku_2014
# class      : RasterBrick 
# dimensions : 4542, 5031, 22850802, 3  (nrow, ncol, ncell, nlayers)
# resolution : 1, 1  (x, y)
# extent     : 0, 5031, 0, 4542  (xmin, xmax, ymin, ymax)
# crs        : NA 
# source     : takuglacierretreat_oli_2014232_lrg.jpg 
# names      : takuglacierretreat_oli_2014232_lrg_1, takuglacierretreat_oli_2014232_lrg_2, takuglacierretreat_oli_2014232_lrg_3

taku_2019
# class      : RasterBrick 
# dimensions : 4542, 5031, 22850802, 3  (nrow, ncol, ncell, nlayers)
# resolution : 1, 1  (x, y)
# extent     : 0, 5031, 0, 4542  (xmin, xmax, ymin, ymax)
# crs        : NA 
# source     : takuglacierretreat_oli_2019221_lrg.jpg 
# names      : takuglacierretreat_oli_2019221_lrg_1, takuglacierretreat_oli_2019221_lrg_2, takuglacierretreat_oli_2019221_lrg_3 

# Plot the 2 images to see the 3 bands 
plot(taku_2014)
dev.off()
plot(taku_2019)
dev.off()

# Let's save this two plot
# Taku 2014 components
jpeg("taku_2014_components.jpg", 900, 900)
plot(taku_2014)
dev.off()
jpeg("taku_2019_components.jpg", 900, 900)
plot(taku_2019)
dev.off()

# Now to see the images with real color we need to use "ggplot2" and "gridExtra" packages functions
# Function "ggRGB" calcolate the composite raster, following the bands order "red, green, blue", using a linear stretch
p1 <- ggRGB(taku_2014,r=1,g=2,b=3, stretch="lin")
p2 <- ggRGB(taku_2019,r=1,g=2,b=3, stretch="lin")
