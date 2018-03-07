#install.packages("shiny")
library("shiny")
library("dplyr")
library("data.table")
library("ggplot2")

df <- read.csv('data/combined.csv', stringsAsFactors = FALSE)
recent <- read.csv('data/recent_grads.csv', stringsAsFactors = FALSE)

shinyServer(function(input, output) {
  
  # Bar graph comparing median earnings in 2012 data and 2016 data
  output$recentGrad <- renderPlot({
    #Had to make the dfm data frame in order to modify the data for this comparison to work
    dfm <- melt(df[,c('Major_Category', 'Major', 'median_earnings_2012', "median_earnings_2016")], id.vars = c('Major_Category', 'Major'))
    plot.dfm <- dfm %>% filter(Major_Category == input$Major_Category)
    ggplot(plot.dfm, aes(x = Major, y = value, color=variable)) + 
           geom_bar(aes(fill = variable), stat = "identity", position = "dodge") +
           theme(axis.text.x = element_text(angle = 60, hjust = 1), axis.title=element_text(face="bold",size="13"), plot.title=element_text(face="bold", size = "18")) +
           ylim(0, 115000) +
           labs(title = "2010-2012 vs 2012-2016 Recent Graduates Median Earnings Comparison", x = "Major", y = "Median Earnings ($)") 
  })
  
  # Bar graph showing the difference in earning between recent and all bachelor degree graduates
  output$earningGrowth <- renderPlot({
    plot.df <- df %>% filter(Major_Category == input$Major_Category)
    ggplot(plot.df, aes(x = Major, y = Median_difference_egc)) + 
           geom_bar(stat = "identity", fill = "purple") + 
           theme(axis.text.x = element_text(angle = 60, hjust = 1), axis.title=element_text(face="bold",size="13"), plot.title=element_text(face="bold", size = "18")) + 
           ylim(0, 85000) + 
           labs(title = "Earnings Growth without Pursuing Higher than Bachelor's Degree", x="Major", y="Difference in Earnings ($)")
  })
  
  #Bar graph showing difference in earnings between bachelor vs graduate degree holders
  output$gradCompare <- renderPlot({
    plot.df <- df %>% filter(Major_Category == input$Major_Category)
    ggplot(plot.df, aes(x = Major, y = Median_difference_gc)) + 
           geom_bar(stat = "identity", fill = "orange") + 
           theme(axis.text.x = element_text(angle = 60, hjust = 1), axis.title=element_text(face="bold",size="13"), plot.title=element_text(face="bold", size = "18")) +
           ylim(0, 100000) + 
           labs(title = "Earnings Increased by Pursuing Higher than Bachelor's Degree", x="Major", y="Difference in Earnings ($)")
  })
  
  #Scatter plot showing female share in earnings compared to overall earning
  output$femaleShare <- renderPlot ({
    ggplot(df, aes(x = female_share, y = median_earnings_overall)) + 
           geom_point(color = c("grey", "red")[(df$Major_Category == input$Major_Category) + 1]) + 
           theme(axis.text.x = element_text(angle = 60, hjust = 1), axis.title=element_text(face="bold",size="13"), plot.title=element_text(face="bold", size = "18")) + 
           labs(title = "Female Share vs Median Earnings in Majors", x = "Percentage of Females in the Major", y = "Median Earnings ($)")
  })
  
  output$table <- renderTable(
    filter(recent, Major_Category == input$Major_Category) %>% 
    select(Major, median_earnings, total_majors, employed, unemployed) 
  )
  
})

