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
# install.packages ("viridis")
library(viridis)
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
p1 <- plotRGB(taku_2014,r=1,g=2,b=3, stretch="lin")
p2 <- plotRGB(taku_2019,r=1,g=2,b=3, stretch="lin")

# Function "grid.arrange"  combine the two plots
grid.arrange (p1,p2,nrow=1,ncol=2)
# Assign the plot to an object
rgb_picture_comparation <- grid.arrange(p1,p2,nrow=1, ncol=2)
# Plot the picture comparation
jpeg("rgb picture, comparation.jpg", 900, 900)
plot(rgb_picture_comparation)
dev.off()

# 1. PCA CALCULATION
# Create a random number of samples from taku_2014 pixels (can't use directly the image from PCA)
sample_2014 <- sampleRandom(taku_2014, 10000)
# Calculate PCA
pca_2014 <- prcomp(sample_2014)
# Variance explained
summary(pca_2014)
# Importance of components:
#                             PC1      PC2     PC3
# Standard deviation     135.4307 11.43075 5.71805
# Proportion of Variance   0.9912  0.00706 0.00177
# Cumulative Proportion    0.9912  0.99823 1.00000
# The 99% of variance is explained from the first component

# Now the second picture
sample_2019 <- sampleRandom(taku_2019, 10000)
pca_2019 <- prcomp(sample_2019)
summary(pca_2019)
# Importance of components:
#                             PC1      PC2     PC3
# Standard deviation     142.6362 11.87155 7.63723
# Proportion of Variance   0.9903  0.00686 0.00284
# Cumulative Proportion    0.9903  0.99716 1.00000
# The 99% of variance is explained from the first component
