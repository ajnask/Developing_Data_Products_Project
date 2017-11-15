#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(dplyr)
crime <- read.csv("./data/CasteCrimeStatusIndia.csv")
total <- read.csv("./data/CasteCrimeTotalIndia.csv")


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
        
        output$Plot <- renderPlot({
                
                # generate the data for plotting
                plotdata <- crime %>%
                        filter(Crime == input$crime , State.UT == input$state|State.UT == input$compare) %>%
                        group_by(State.UT,Year) %>%
                        summarise(Total = sum(Count))
                
                # draw the plot with the specified data
                p <- ggplot(plotdata,aes(Year,Total,group = State.UT)) +
                        geom_point(col = "darkred",size = 2) + 
                        geom_line(aes(col = State.UT)) +
                        scale_x_continuous(breaks = seq(2001,2013,1)) +
                        theme(axis.text = element_text(size = 11,face = "bold"),
                              panel.background = element_blank(),
                              axis.line = element_line(color = "black"),
                              panel.grid.major = element_line(color = grey(0.95)),
                              axis.title = element_text(face = "bold",size = 14),
                              legend.title = element_blank(),
                              legend.text = element_text(size = 12)
                        )
                print(p)
                
        }, height = 550,width = 800)
        
        output$Totaltable <- renderTable({
                table <- total %>%
                        filter(Crime == input$crimeTotal,Year == input$year) %>%
                        group_by(State.UT,Year) %>%
                        summarise(Count = sum(Count))
                print(table)
        },width = 800)
        
})
