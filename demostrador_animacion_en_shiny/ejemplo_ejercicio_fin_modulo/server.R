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
library(ggrepel)

shinyServer(function(input, output) {
  output$plot <- renderPlot({
    datos <- gapminder[gapminder$continent == input$x, ]
    paises <- gapminder$country[gapminder$continent == input$x]

      p <- ggplot(datos, aes(gdpPercap, 
                               lifeExp, 
                               size = pop, 
                               colour = country,
                               label = paises)) +
      geom_text(show.legend = FALSE) +
      geom_point(alpha = 0.7, show.legend = FALSE) +
      scale_colour_manual(values = country_colors) +
      scale_size(range = c(2, 12)) +
      scale_x_log10() +
#      facet_wrap(~continent) +
      # Here comes the gganimate specific bits
      labs(title = 'Year: {frame_time}', 
           x = 'GDP per capita', 
           y = 'life expectancy') +
      transition_time(year) +
      ease_aes('linear')
    
#    animate(p, renderer = file_renderer('./animation/'))
    
    animate(p, renderer = gifski_renderer(file = 'gif.gif'))
  })
})


