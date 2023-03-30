# My first code in Git Hub
# Let's install the raster package

install.packages("raster")

library(raster)

# Import data, setting the working directory
setwd("C:/Lab/")

l2011 <- brick("p224r63_2011_masked.grd")

# plotting the data in a savage manner
plot(l2011)

cl <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot(l2011, col=cl) # per assegnare i nuovi colori alle immagini

# plotting one element
plot(l2011[[4]], col=cl)

# Change the colour gamut for all images
cl <- colorRampPalette(c("blue", "brown", "chartreuse", "chocolate", "darkorange")) (100)
plot(l2011, col=cl)
cl <- colorRampPalette(c("cyan", "azure", "darkorchid", "aquamarine")) (100)
plot(l2011, col=cl)

# Plot the NIR band
plot(l2011[[4]], col=cl)

# dev.off() it closes graph

# Export graphs in R
pdf("myfirstgraph.pdf")
plot(l2011[[4]], col=cl)
dev.off()

# Plotting several bands in a multiframe
par(mfrow=c(2,1))
plot(l2011[[3]], col=cl)
plot(l2011[[4]], col=cl)

# Plotting the first 4 bands
par(mfrow=c(2,2))
# Blue
clb <- colorRampPalette(c("blue4", "blue2", "light blue")) (100)
plot(l2011[[1]], col=clb)
# Green
clg <- colorRampPalette(c("chartreuse4", "chartreuse2", "chartreuse")) (100)
plot(l2011[[2]], col=clg)
# Red
clr <- colorRampPalette(c("brown4", "brown2", "brown")) (100)
plot(l2011[[3]], col=clr)
# NIR
cln <- colorRampPalette(c("darkgoldenrod4", "darkgoldenrod2", "darkgoldenrod")) (100)
plot(l2011[[4]], col=cln)



library(raster)
setwd("C:/Lab/")
l2006 <- brick("defor2_.png")
plotRGB(l2006, 1, 2, 3, stretch="Lin")
