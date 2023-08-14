# This is the code for my Telerilevamento Geo-Ecologico exam
# This code will focus to the loss of snow of the Mendenhall glacier, in Alaska

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
# install.packages ("viridis")
library(viridis)
# Now set the working directory
setwd ("C:/lab/Esame")

# We can call our objects, for this code we need two images of two different years (2014 - 2019) of Mendenhall glacier
# Assign to those images a name
mendenhall_1984 <- brick("mendenhallglacier_tm5_1984230_lrg.jpg")
mendenhall_2023 <- brick("mendenhallglacier_oli_2023209_lrg.jpg")

# Call them to see the imformation inside

mendenhall_1984
# class      : RasterBrick 
# dimensions : 585, 877, 513045, 3  (nrow, ncol, ncell, nlayers)
# resolution : 1, 1  (x, y)
# extent     : 0, 877, 0, 585  (xmin, xmax, ymin, ymax)
# crs        : NA 
# source     : mendenhallglacier_tm5_1984230_lrg.jpg 
# names      : mendenhallglacier_tm5_1984230_lrg_1, mendenhallglacier_tm5_1984230_lrg_2, mendenhallglacier_tm5_1984230_lrg_3
mendenhall_2023
# class      : RasterBrick 
# dimensions : 585, 877, 513045, 3  (nrow, ncol, ncell, nlayers)
# resolution : 1, 1  (x, y)
# extent     : 0, 877, 0, 585  (xmin, xmax, ymin, ymax)
# crs        : NA 
# source     : mendenhallglacier_oli_2023209_lrg.jpg 
# names      : mendenhallglacier_oli_2023209_lrg_1, mendenhallglacier_oli_2023209_lrg_2, mendenhallglacier_oli_2023209_lrg_3

# Plot the 2 images to see the 3 bands 
plot(mendenhall_1984)
dev.off()
plot(mendenhall_2023)
dev.off()

# Let's save this two plot
# Mendenhall 1984 components
jpeg("mendenhall_1984_components.jpg", 900, 900)
plot(mendenhall_1984)
dev.off()
jpeg("mendenhall_2023_components.jpg", 900, 900)
plot(mendenhall_2023)
dev.off()

# Now to see the images with real color we need to use "ggplot2"
# Function "ggRGB" calcolate the composite raster, following the bands order "red, green, blue", using a linear stretch
plotRGB(mendenhall_1984,r=1,g=2,b=3, stretch="lin")
plotRGB(mendenhall_2023,r=1,g=2,b=3, stretch="lin")

# Combine the two plots into one to compare them
par(mfrow=c(1,2))
plotRGB(mendenhall_1984,r=1,g=2,b=3, stretch="lin")
plotRGB(mendenhall_2023,r=1,g=2,b=3, stretch="lin")


# 1. PCA CALCULATION
# Create a random number of samples from mendenhall_1984 pixels (can't use directly the image from PCA)
sample_1984 <- sampleRandom(mendenhall_1984, 10000)
# Calculate PCA
pca_1984 <- prcomp(sample_1984)
# Variance explained
summary(pca_1984)
# Importance of components:
#                             PC1     PC2      PC3
# Standard deviation     105.6623 50.7469 25.86243
# Proportion of Variance   0.7749  0.1787  0.04642
# Cumulative Proportion    0.7749  0.9536  1.00000
# The 77% of variance is explained from the first component

# Now the second picture
sample_2023 <- sampleRandom(mendenhall_2023, 10000)
pca_2023 <- prcomp(sample_2023)
summary(pca_2023)
# Importance of components:
#                            PC1     PC2      PC3
# Standard deviation     103.631 55.0884 29.26900
# Proportion of Variance   0.734  0.2074  0.05855
# Cumulative Proportion    0.734  0.9415  1.00000
# The 73% of variance is explained from the first component
 
# Principal components map
pci_1984 <- predict(mendenhall_1984, pca_1984, index=c(1:2))
plot(pci_1984[[1]])
pci_2023 <- predict(mendenhall_2023, pca_2023, index=c(1:2))
plot(pci_2023[[1]])

# ggplot
pcid_1984 <- as.data.frame(pci_1984[[1]], xy=T)
pcid_1984
ggplot() +
geom_raster(pcid_1984, mapping = aes(x=x, y=y, fill=PC1)) +
scale_fill_viridis() +
ggtitle("pci 1984")

pcid_2023 <- as.data.frame(pci_2023[[1]], xy=T)
pcid_2023
ggplot() +
geom_raster(pcid_2023, mapping = aes(x=x, y=y, fill=PC1)) +
scale_fill_viridis() +
ggtitle("pci 2023")


# 2. LOSS OF SNOW
# Assign a name to the 2014 picture first component
b1_2014 <- taku_2014$takuglacierretreat_oli_2014232_lrg_1
# Assign a name to the 2019 picture first component
b1_2019 <- taku_2019$takuglacierretreat_oli_2019221_lrg_1
# Save the two plots
jpeg("2014_component_1.jpg", 900, 900)
plot(b1_2014, main = "2014 first component")
dev.off()
jpeg("2019_component_1.jpg", 900, 900)
plot(b1_2019, main = "2019 first component")
dev.off()
