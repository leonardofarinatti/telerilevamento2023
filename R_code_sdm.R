# R code for species distribution modelling

library(sdm)
library(rgdal)
library(raster)

file <- system.file("external/species.shp", package="sdm")
file
species <- shapefile(file)
species
plot(species)
plot(species, pch= 19)

presences <- species[species$Occurrence == 1,]
plot(presences, col="blue", pch=19)
absences <- species[species$Occurrence == 0,]
plot(absences, col="red", pch=19)
plot(presences, col="blue", pch=19)
points(absences, col="red", pch=19) # funzione che serve per plottare le assenze assieme alle presenze

# predictors: look at the path
path <- system.file("external", package="sdm")
# list the predictors
lst <- list.files(path=path,pattern='asc$',full.names = T)
lst

# stack
preds <- stack(lst)

# plot preds
cl <- colorRampPalette(c('blue','orange','red','yellow')) (100)
plot(preds, col=cl)

# plot predictors and occurrences
plot(preds$elevation, col=cl)
points(presences, pch=19)
plot(preds$temperature, col=cl)
points(presences, pch=19)
plot(preds$precipitation, col=cl)
points(presences, pch=19)
plot(preds$vegetation, col=cl)
points(presences, pch=19)
