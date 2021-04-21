#
# A partir de consulta participante en master 2021
# Manejo de fechas en slider
# Tomado de https://stackoverflow.com/questions/40908808/how-to-sliderinput-for-dates

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    
    # Application title
    titlePanel("St Thomas' Physiology Data Console"),
    
    # Sidebar with a slider input for the number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("DatesMerge",
                        "Dates:",
                        min = as.Date("2016-01-01","%Y-%m-%d"),
                        max = as.Date("2016-12-01","%Y-%m-%d"),
                        value=as.Date("2016-12-01"),
                        timeFormat="%Y-%m-%d")
        ),
        mainPanel(
            plotOutput("distPlotLactul"))
        
    )
))
