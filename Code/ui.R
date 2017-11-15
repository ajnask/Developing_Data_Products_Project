#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
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
url <- a("OGD Website",href="https://data.gov.in/catalog/crime-against-schedule-caste")
castelink <- a("Caste System in India",href= "https://en.wikipedia.org/wiki/Caste_system_in_India")
casteviolence <- a("Caste Violence in India",href = "https://en.wikipedia.org/wiki/Caste-related_violence_in_India")

# Define UI for application that draws a histogram
shinyUI(fluidPage(
        
        # Application title
        titlePanel("Caste Based Crime Status in India"),
        
        # Sidebar with a slider input for number of bins 
        tabsetPanel(
                tabPanel("Plot", fluid = TRUE,
                         sidebarLayout(
                                 sidebarPanel(
                                         selectInput("crime","Crime",unique(crime$Crime)),
                                         selectInput("state","State/UT",unique(crime$State.UT)),
                                         selectInput("compare","Compare with",c("None",levels(crime$State.UT)))
                                 ),
                                 
                                 # Show a plot of the generated distribution
                                 mainPanel(
                                         plotOutput("Plot")
                                 )
                         )
                ),
                tabPanel("Total", fluid = TRUE,
                         sidebarLayout(
                                 sidebarPanel(
                                         sliderInput("year","Year",min = 2001,max = 2013,value = 2001),
                                         selectInput("crimeTotal","Crime",unique(total$Crime))
                                 ),
                                 
                                 # Show a plot of the generated distribution
                                 mainPanel(
                                         tableOutput("Totaltable")
                                 )
                         )
                ),
                tabPanel("Documentation",
                         mainPanel(
                                 h4(
                                         "This Shiny App is to visualize the horror of Caste Based Crime committed all around India. ",
                                         "Caste-related violence has occurred and occurs in India in various forms.",
                                         "According to a report by Human Rights Watch, Dalits and indigenous people",
                                         " (known as Scheduled Tribes or adivasis) continue to face discrimination, exclusion, and acts of communal violence.",
                                         " Laws and policies adopted by the Indian government provide a strong basis for protection, ",
                                         "but are not being faithfully implemented by local authorities. ",
                                         "To know more about caste please look up the link", tagList(castelink),".", 
                                         tagList("Here is a wikipedia page of some of the infamous violences,",casteviolence),".",
                                         "Data for the analysis was taken from Open Government Data Platform India (OGD).",
                                         " Datasets for years from 2001 to 2013 was downloaded and complied accordingly."
                                 ),
                                 tagList("Link to the website is",url)
                                )
                         )
        )
)
)
