#
# Ejemplo de app shiny para master UNED Big Data
# Módulo visualización avanzada
#
# Ejemplo de animación dentro de shiny
# usando el ejemplo de https://gganimate.com/
# en concreto el de librería gapminder

library(shiny)
library(ggplot2)
library(gganimate)
library(gapminder)
library(gifski)


shinyUI(
  navbarPage("Demostrador de gganimate dentro de Shiny",
                   tabPanel("Descripción del trabajo",
                            mainPanel(
                              h2("Propuesto por Pedro Concejero", align = "center"),
                              p("Demostrador de gganimate dentro de shiny"),
                            )),
                   tabPanel("Animación",
                            sidebarPanel(
                              
                              selectInput('x', 
                                          'Elige continente', 
                                          levels(gapminder$continent), 
                                          levels(gapminder$continent)[1])                            ),
                            
                            mainPanel(
                              plotOutput('plot',
                                         height=500)
                              
                            )
                   )
))

