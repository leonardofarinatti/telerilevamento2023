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

# model

# set the data for the sdm
datasdm <- sdmData(train=species, predictors=preds)
# model # modello lineare generalizzato
m1 <- sdm(Occurrence ~ elevation + precipitation + temperature + vegetation, data=datasdm, methods = "glm")
# make the raster output layer
p1 <- predict(m1, newdata=preds) 
# plot the output
plot(p1, col=cl)
points(presences, pch=19)

# add to the stack
s1 <- stack(preds,p1)
plot(s1, col=cl)
names(s1) <- c('elevation', 'precipitation', 'temperature', 'vegetation', 'model')

# Do you want to change names in the plot of the stack?
# Here your are!:
# choose a vector of names for the stack, looking at the previous graph, qhich are:
names(s1) <- c('elevation', 'precipitation', 'temperature', 'vegetation', 'model')
# and then replot!:
plot(s1, col=cl)
# you are done, with one line of code (as usual!)
