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

#plotting one element
plot(l2011[[4]], col=cl)
