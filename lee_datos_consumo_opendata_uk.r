rm(list=ls()); gc()

setwd("D:/2017/master UNED curso visualizacion")

library(data.table)

download.file("http://carfueldata.direct.gov.uk/additional/aug2016/download-data-for-Aug-2016-Euro-6.zip",
              destfile = "rawdatos.zip")

unzip("rawdatos.zip")

datos <- fread(unzip("rawdatos.zip"))

summary(datos)

head(datos)
dim(datos)

datos <- as.data.frame(datos)

datos$'Fuel Cost 12000 Miles' <- gsub('£', '', datos$'Fuel Cost 12000 Miles')
datos$'Fuel Cost 12000 Miles' <- as.numeric(gsub(',', '', datos$'Fuel Cost 12000 Miles'))

datos$'Electricity cost' <- gsub('£', '', datos$'Electricity cost')
datos$'Electricity cost' <- as.numeric(gsub(',', '', datos$'Electricity cost'))

datos$'Total cost / 12000 miles' <- gsub('£', '', datos$'Total cost / 12000 miles')
datos$'Total cost / 12000 miles' <- as.numeric(gsub(',', '', datos$'Total cost / 12000 miles'))

summary(datos)

names(datos)

names(datos) <- gsub(" ", "", names(datos))
names(datos) <- gsub("\\(", "", names(datos))
names(datos) <- gsub("\\)", "", names(datos))
names(datos) <- gsub("\\/", "", names(datos))
names(datos) <- gsub("\\[", "", names(datos))
names(datos) <- gsub("\\]", "", names(datos))
names(datos) <- gsub("\\.", "_", names(datos))

names(datos)

table(datos$FuelType)

save(datos, file = "D:/2017/master UNED curso visualizacion/repo github/master_UNED/datos_4510_vehiculos_2016.rda")
