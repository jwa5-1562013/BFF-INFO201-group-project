#install.packages("shiny")
library("shiny")


shinyUI(fluidPage(    
  
  # Give the page a title
  titlePanel("College Majors"),
  
  # Generate a row with a sidebar
  sidebarLayout(      
    
    #Sidebar dropdown menu to alter Major Category
    sidebarPanel(
      selectInput("Major_Category", "Major Category:",
                  choices=unique(df$Major_Category))
     
    ),
    
    # Create a spot for the plots on individual tabs, also include text descriptions
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Recent Grad Earning", plotOutput("recentGrad"),
                           tags$body(paste("PUT NOTES HERE"))),
                  tabPanel("Earning Growth", plotOutput("earningGrowth"),
                           tags$body(paste("PUT NOTES HERE"))),
                  tabPanel("Degree earning comparison", plotOutput("gradCompare"),
                           tags$body(paste("PUT NOTES HERE"))),
                  tabPanel("Female earning", plotOutput("femaleShare"),
                           tags$body(paste("PUT NOTES HERE")))
      )
    )
  )
))




