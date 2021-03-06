# Recordad SIEMPRE cambiar la ruta (path) a vuestro directorio de trabajo
setwd("/home/pedro/Escritorio/uned 2019/master_UNED_2020/master_UNED")

# Necesario cargar la librería ggplot2
library(ggplot2)


load("mtcars.rda")

mtcars$cilindros <- as.numeric(as.character(mtcars$cyl))

# Un gráfico rápido con qplot

qplot(x = tons,
      y = litperkm,
      color = cilindros,
      data = mtcars, 
      geom = "point")

# No me gusta que se represente num cilindros con color
# Probemos con forma, pero del factor (cyl)

qplot(x = tons,
      y = litperkm,
      shape = cyl,
      data = mtcars, 
      geom = "point")

#  ggplot permite añadir capas enriqueciendo el gráfico

ggplot(mtcars, 
       aes(tons, litperkm)) +
  geom_point(aes(shape = cyl)) +
  geom_smooth(method ="lm") +
  coord_cartesian() +
  scale_color_gradient() +
  theme_bw()

# Gráfico de dispersión con region hexadecimal

ggplot(mtcars, 
       aes(tons, litperkm)) +
  geom_hex() +
  geom_smooth(method ="lm") +
  coord_cartesian() +
  scale_color_gradient() +
  theme_bw()

# Histograma básico

ggplot(mtcars, 
       aes(litperkm)) +
  geom_histogram()

ggplot(mtcars, 
       aes(litperkm, fill = cyl)) +
  geom_histogram(binwidth = 1)

ggplot(mtcars, 
       aes(litperkm, fill = cyl)) +
  geom_histogram(binwidth = 1) +
  geom_freqpoly()

ggplot(mtcars, 
       aes(litperkm, fill = cyl)) +
  geom_histogram(binwidth = 1) +
  geom_freqpoly(binwidth = 1)

ggplot(mtcars, 
       aes(litperkm, fill = cyl)) +
  geom_histogram(binwidth = 1) +
  scale_fill_brewer(palette = "Reds")

# Boxplot

ggplot(mtcars, 
       aes(cyl, litperkm)) +
  geom_boxplot()

# Se puede mejorar muchísimo
# Vemos ejemplo de cómo encadenar capas

p <- ggplot(mtcars, 
            aes(cyl, litperkm))
  
p + geom_boxplot() + 
  geom_jitter(width = 0.2) +
  theme_gray()

glotones <- row.names(mtcars[mtcars$litperkm == max(mtcars$litperkm),])
glotones

p <- ggplot(mtcars, 
            aes(cyl, litperkm,
                label = row.names(mtcars)))
p + geom_boxplot() +
  geom_text(aes(label = row.names(mtcars)),
            hjust=0, 
            vjust=0,
            size = 2) 

# Gráfico refinado

p <- ggplot(mtcars, 
            aes(cyl, litperkm))

p + geom_boxplot() + 
  annotate(geom = "text",
             x = 3,
             y = 22,
             label = glotones[1],
           size = 3) + 
  annotate(geom = "text",
           x = 3,
           y = 21,
           label = glotones[2],
           size = 3) +
  labs(title = "Boxplot consumo por número cilindros anotado")


