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
