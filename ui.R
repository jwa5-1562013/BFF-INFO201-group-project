#install.packages("shiny")
library("shiny")

cereals <- read.table("data/cereal.tsv", header = TRUE, stringsAsFactors = FALSE)

my.ui <- fluidPage(    
  
  # Give the page a title
  titlePanel("Ratings of Cereals by Manufacturer"),
  
  # Generate a row with a sidebar
  sidebarLayout(      
    
    # Define the sidebar with one select input and one numeric input
    sidebarPanel(
      selectInput("mfr", "Manufacturer:",
                  choices=unique(cereals$mfr)),
      numericInput("calories", "Calories per Serving Threshold:", 100, min = 50, max = 160, step = 10),
      hr(),
      helpText(p("Manufacturers are represented by the following letters:"),
               p("A: American Home Food Products"),
               p("G: General Mills"),
               p("K: Kelloggs"),
               p("N: Nabisco"),
               p("P: Post"),
               p("Q: Quaker Oats"),
               p("R: Ralston Purina"),
               p(em("Calories threshold determines the acceptable calories level. Any cereal with 
                 less than indicated calories will appear in green and red otherwise")))
    ),
    
    # Create a spot for the barplot and the tabs for the names of cereals
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Plot", plotOutput("mfr")),
                  tabPanel("Names of Cereals", tableOutput("name")),
                  tabPanel("", plotOutput(""))
      )
    )
  )
)

shinyUI(my.ui)


