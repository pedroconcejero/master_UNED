
# ayuda a Paula Muñoz alumna master uned 2018

# Datos accidentes M30 de Ayto. Madrid

# Debemos descargarlos *MANUALMENTE* de aquí:

# https://datos.madrid.es/portal/site/egob/menuitem.c05c1f754a33a9fbe4b2e4b284f1a5a0/?vgnextoid=6e1ce0f3e8e22610VgnVCM1000001d4a900aRCRD&amp;vgnextchannel=374512b9ace9f310VgnVCM100000171f5a0aRCRD&amp;vgnextfmt=default

# He descargado los ficheros de datos 2017 y 2018 y ahora intentaré leerlos
# primero  los csv's que serán más fáciles

library(data.table)

# pon tu directorio de trabajo (donde tengas los ficheros datos)

setwd("D:/2018/master_UNED_2018/paula muñoz")

# con este comando puedes ver los ficheros descargados
list.files()

# leemos los datos de 2017
# atencion a la opción stringsAsFactors!!!

datos_2017 <- fread("Listado_accidentes_2017.csv",
                    stringsAsFactors= TRUE)

summary(datos_2017)

# Gráfico 1: número de vehículos implicados y número de turismos
# Aunque es perfectamente posible, un gráfico de dispersión (scatterplot) no dice nada
# Te propongo un gráfico de mosaico (mosaicplot) que permite visualización de variables categóricas

# Pasamos las variables número de vehículos y número de turismos a factores

names(datos_2017)

datos_2017$'n_vehiculos' <- as.factor(datos_2017$`Nº Vehículos implicados`)
datos_2017$'n_turismos' <- as.factor(datos_2017$`Nº Turismos`)

# Los mejores gráficos de mosaico, en mi opinión, son los de la librería vcd
# Acrónimo de 'visualization categorical data'

install.packages("vcd")

library(vcd)

# Primero creamos la tabla que queremos dibujar

t <- table(datos_2017$n_vehiculos, 
           datos_2017$n_turismos,
           useNA = "no")

# Muestra la distribución de número de vehículos implicados en accidentes

mosaic(~ n_vehiculos + n_turismos, 
       data = datos_2017,
       shade=TRUE, 
       legend=TRUE) 

mosaic(~ n_turismos + n_vehiculos, 
       data = datos_2017,
       shade=TRUE, 
       legend=TRUE) 

table(datos_2017$n_turismos, datos_2017$n_vehiculos)

# Lo que sucede:
# Lo totalmente habitual es que el número de turismos coincida con el número de vehículos
# (1 vehículo = turismo, 2 vehículos= 994 turismos..)
# Tampoco me parece muy relevante
# Veamos número vehículos pesados

datos_2017$'n_pesados' <- as.factor(datos_2017$`Nº vehículos pesados`)

mosaic(~ n_pesados + n_vehiculos, 
       data = datos_2017,
       shade=TRUE, 
       legend=TRUE) 

# Parece que aquí sí puede haber una relación: mayor n_ vehículos más prob. uno sea pesado
# Casi no hay accidentes entre varios pesados

# VEAMOS la distribución CONJUNTA de número de TURISMOS
# POR FACTORES ATMOSFERICOS

# vcd no nos deja usar esos nombres de variables con acentos
# cambiamos nombre con names

names(datos_2017)[30] <- "factores_atmosfericos"

mosaic(~ n_turismos + factores_atmosfericos, 
       data = datos_2017,
       shade=TRUE, 
       legend=TRUE) 

# Mayor probabilidad de accidente *de solo 1 vehiculo* con lluvia

# Veamos por tipo de accidente

names(datos_2017)[11] <- "tipos_de_accidente"

mosaic(~ tipos_de_accidente + n_turismos, 
       data = datos_2017,
       shade=TRUE, 
       legend=TRUE) 

# Hay un problema ENORME en los valores de las variables
# Aparecen como diferentes Colision de vehiculos, Colision de vehículos Colisión de vehículos
# Hay que ponerlos todos a mismo valor

datos_2017$tipos_de_accidente <- as.character(datos_2017$tipos_de_accidente)
datos_2017$tipos_de_accidente[datos_2017$tipos_de_accidente == "Colision de vehiculos"] <- "colision"
datos_2017$tipos_de_accidente[datos_2017$tipos_de_accidente == "Colision de vehículos"] <- "colision"
datos_2017$tipos_de_accidente[datos_2017$tipos_de_accidente == "Colisión de vehículos"] <- "colision"
datos_2017$tipos_de_accidente[datos_2017$tipos_de_accidente == "Colisión obstaculo"] <- "obstaculo"
datos_2017$tipos_de_accidente[datos_2017$tipos_de_accidente == "Salida de vía"] <- "salida"
datos_2017$tipos_de_accidente[datos_2017$tipos_de_accidente == "Salida de Vía"] <- "salida"

table(datos_2017$tipos_de_accidente)

mosaic(~ tipos_de_accidente + n_turismos, 
       data = datos_2017,
       shade=TRUE, 
       legend=TRUE,
       labeling= labeling_border(rot_labels = c(0,0,0,0), 
                                 just_labels = c("right", 
                                                 "right", 
                                                 "right", 
                                                 "right"))) 

# Aunque parece un poco obvio... 
# Mayoría de colisiones son entre dos o más vehículos
# Las salidas de vía y colisión con obstáculos son mayoritariamente 1 solo vehículo
# Aunque parece un poco trivial
# Veamos por factores atmosféricos

mosaic(~ tipos_de_accidente + factores_atmosfericos, 
       data = datos_2017,
       shade=TRUE, 
       legend=TRUE,
       labeling= labeling_border(rot_labels = c(90,0,0,0), 
                                 just_labels = c("left", 
                                                 "right", 
                                                 "right", 
                                                 "right"))) 

# Hay mayor probabilidad de salida de vía con Lluvia

table(datos_2017$`Estado del Firme`)

names(datos_2017)[22] <- "estado_firme"

mosaic(~ tipos_de_accidente + estado_firme, 
       data = datos_2017,
       shade=TRUE, 
       legend=TRUE,
       labeling= labeling_border(rot_labels = c(90,0,0,0), 
                                 just_labels = c("left", 
                                                 "right", 
                                                 "right", 
                                                 "right"))) 

# salida de vía mucha más probabilidad con mojado
# ¡¡Y vuelco!!

