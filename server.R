#install.packages("shiny")
library("shiny")
library("dplyr")

source("data_analysis.R")

my.server <- function(input, output) {
  
  # Fill in the spot we created for a plot
  output$mfr <- renderPlot({
    
    # Render a barplot
    barplot(cereals[cereals$mfr == input$mfr, "rating"], 
            main = paste0("Ratings of Cereals by Manufacturer ", input$mfr),
            names.arg = 1:(filter(cereals, mfr == input$mfr) %>% nrow()),
            
            # Color code the bars depending on the level of calories and the user input threshold
            # (FALSE + 1 -> 1 -> "green";    TRUE + 1 -> 2 -> "red")
            col = c("green", "red")[(cereals$calories > input$calories) + 1],
            ylab ="Ratings",
            ylim = c(0,100),
            xlab ="Name Indexes")
  })
  
  # Since the names are too long to be put on the x-axis, created a separate tab of table
  # to list the names with corresponding name index number
  output$name <- renderTable(
    filter(cereals, mfr == input$mfr) %>% mutate(name = gsub("_", " ", name)) %>% select(name),
    rownames = TRUE
  )
}

shinyServer(my.server)