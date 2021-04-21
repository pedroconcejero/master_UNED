#
# A partir de consulta participante en master 2021
# Manejo de fechas en slider
# Tomado de https://stackoverflow.com/questions/40908808/how-to-sliderinput-for-dates

library(shiny)
library(data.table)
library(lubridate)
library(ggplot2)

TotsLactul        <- rep(ymd("2016-01-01"),100)
randomMonths      <- round(runif(n = 100,min = 0,max = 11),0) 
randomDays        <- round(runif(n = 100,min = 0,max = 28),0)

# Increments days
month(TotsLactul) <- month(TotsLactul) + randomMonths  
day(TotsLactul)   <- day(TotsLactul)   + randomDays  

# Make it a DT
TotsLactul        <- data.table(x=TotsLactul)


shinyServer(function(input, output) {
    
    output$distPlotLactul <- renderPlot({
        #Create the data
        DatesMerge<-input$DatesMerge
        
        # draw the histogram with the specified number of bins
        ggplot(TotsLactul[month(x) == month(DatesMerge)],mapping=aes(x=x))+
            geom_histogram(bins=100)+
            labs(title=paste("Num")) +
            xlab("Time") +
            ylab("NumP") +
            theme(axis.text.x=element_text(angle=-90)) +
            theme(legend.position="top")+
            theme(axis.text=element_text(size=6))
        
        
    })
    
    
})
