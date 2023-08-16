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
# Function "plotRGB" calcolate the composite raster, following the bands order "red, green, blue", using a linear stretch
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
# Assign a name to the 1984 picture first component
b1_1984 <- mendenhall_1984$mendenhallglacier_tm5_1984230_lrg_1
# Assign a name to the 2023 picture first component
b1_2023 <- mendenhall_2023$mendenhallglacier_oli_2023209_lrg_1
# Save the two plots
jpeg("1984_component_1.jpg", 900, 900)
plot(b1_1984, main = "1984 first component")
dev.off()
jpeg("2023_component_1.jpg", 900, 900)
plot(b1_2023, main = "2023 first component")
dev.off()

# Calcolate the difference between the 2 components
diff <- b1_1984 - b1_2023
# Make a new color palette to visualize the plot better
cl <- colorRampPalette(c('yellow','black','red'))(100)
# Plot the difference
plot(diff, col=cl, main = "loss of snow")
dev.off()
# Save this plot
jpeg("diff.jpg", 900, 900)
plot(diff, col=cl, main = "perdita manto nevoso")
dev.off()


# 3. STANDARD DEVIATION CALCULATION
# The function to use for this is "focal", compute the focal values for the adjacent focal cells using a matrix
# Set the matrix size, in this case a matrix with 5 rows and 5 columns
# Set the function, in this case "sd" for standard deviation
devst <- focal(diff, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
# Make a new color palette to visualize the plot better
cl2 <- colorRampPalette(c("blue","green","yellow","magenta"))(100)
plot(devst, col=cld, main="standard deviation")
dev.off()
# Now save this plot
jpeg("standard deviation map.jpg", 900, 900)
plot(devst, col=cl2, main="deviazione standard")
dev.off()
