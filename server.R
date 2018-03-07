#install.packages("shiny")
library("shiny")
library("dplyr")
library("data.table")
library("ggplot2")

df <- read.csv('data/combined.csv', stringsAsFactors = FALSE)

shinyServer(function(input, output) {
  
  # Bar graph comparing median earnings in 2012 data and 2016 data
  output$recentGrad <- renderPlot({
    
    #Had to make the dfm data frame in order to modify the data for this comparison to work
    dfm <- melt(df[,c('Major_Category', 'Major', 'median_earnings_2012', "median_earnings_2016")], id.vars = c('Major_Category', 'Major'))
    if(input$Major_Category == 'Agriculture & Natural Resources') {
      plot.dfm <- dfm %>% filter(Major_Category == 'Agriculture & Natural Resources')
    } else if(input$Major_Category == 'Arts') {
      plot.dfm <- dfm %>% filter(Major_Category == 'Arts')
    } else if(input$Major_Category == 'Biology & Life Science') {
      plot.dfm <- dfm %>% filter(Major_Category == 'Biology & Life Science')
    } else if(input$Major_Category == 'Business') {
      plot.dfm <- dfm %>% filter(Major_Category == 'Business')
    } else if(input$Major_Category == 'Communications & Journalism') {
      plot.dfm <- dfm %>% filter(Major_Category == 'Communications & Journalism')
    } else if(input$Major_Category == 'Computers & Mathematics') {
      plot.dfm <- dfm %>%filter(Major_Category == 'Computers & Mathematics')
    } else if(input$Major_Category == 'Education') {
      plot.dfm <- dfm %>% filter(Major_Category == 'Education')
    } else if(input$Major_Category == 'Engineering') {
      plot.dfm <- dfm %>% filter(Major_Category == 'Engineering')
    } else if(input$Major_Category == 'Health') {
      plot.dfm <- dfm %>% filter(Major_Category == 'Health')
    } else if(input$Major_Category == 'Humanities & Liberal Arts') {
      plot.dfm <- dfm %>% filter(Major_Category == 'Humanities & Liberal Arts')
    } else if(input$Major_Category == 'Industrial Arts & Consumer Services') {
      plot.dfm <- dfm %>% filter(Major_Category == 'Industrial Arts & Consumer Services')
    } else if(input$Major_Category == 'Interdisciplinary') {
      plot.dfm <- dfm %>% filter(Major_Category == 'Interdisciplinary')
    } else if(input$Major_Category == 'Law & Public Policy') {
      plot.dfm <- dfm %>% filter(Major_Category == 'Law & Public Policy')
    } else if(input$Major_Category == 'Physical Sciences') {
      plot.dfm <- dfm %>% filter(Major_Category == 'Physical Sciences')
    } else if(input$Major_Category == 'Psychology & Social Work') {
      plot.dfm <- dfm %>% filter(Major_Category == 'Psychology & Social Work')
    } else if(input$Major_Category == 'Social Science') {
      plot.dfm <- dfm %>% filter(Major_Category == 'Social Science')
    } 
    ggplot(plot.dfm, aes(x = Major, y = value, color=variable)) + geom_bar(aes(fill = variable), stat = "identity", position = "dodge") + theme(axis.text.x=element_text(angle=60,hjust=1)) + labs(x="Major", y="Median Earnings")
  })
  
  # Bar graph showing the difference in earning between recent and all bachelor degree graduates
  output$earningGrowth <- renderPlot({
    if(input$Major_Category == 'Agriculture & Natural Resources') {
      plot.df <- df %>% filter(Major_Category == 'Agriculture & Natural Resources')
    } else if(input$Major_Category == 'Arts') {
      plot.df <- df %>% filter(Major_Category == 'Arts')
    } else if(input$Major_Category == 'Biology & Life Science') {
      plot.df <- df %>%filter(Major_Category == 'Biology & Life Science')
    } else if(input$Major_Category == 'Business') {
      plot.df <- df %>% filter(Major_Category == 'Business')
    } else if(input$Major_Category == 'Communications & Journalism') {
      plot.df <- df %>% filter(Major_Category == 'Communications & Journalism')
    } else if(input$Major_Category == 'Computers & Mathematics') {
      plot.df <- df %>% filter(Major_Category == 'Computers & Mathematics')
    } else if(input$Major_Category == 'Education') {
      plot.df <- df %>% filter(Major_Category == 'Education')
    } else if(input$Major_Category == 'Engineering') {
      plot.df <- df %>% filter(Major_Category == 'Engineering')
    } else if(input$Major_Category == 'Health') {
      plot.df <- df %>% filter(Major_Category == 'Health')
    } else if(input$Major_Category == 'Humanities & Liberal Arts') {
      plot.df <- df %>% filter(Major_Category == 'Humanities & Liberal Arts')
    } else if(input$Major_Category == 'Industrial Arts & Consumer Services') {
      plot.df <- df %>% filter(Major_Category == 'Industrial Arts & Consumer Services')
    } else if(input$Major_Category == 'Interdisciplinary') {
      plot.df <- df %>% filter(Major_Category == 'Interdisciplinary')
    } else if(input$Major_Category == 'Law & Public Policy') {
      plot.df <- df %>% filter(Major_Category == 'Law & Public Policy')
    } else if(input$Major_Category == 'Physical Sciences') {
      plot.df <- df %>% filter(Major_Category == 'Physical Sciences')
    } else if(input$Major_Category == 'Psychology & Social Work') {
      plot.df <- df %>% filter(Major_Category == 'Psychology & Social Work')
    } else if(input$Major_Category == 'Social Science') {
      plot.df <- df %>% filter(Major_Category == 'Social Science')
    } 
    ggplot(plot.df, aes(x = Major, y = Median_difference_egc)) + geom_bar(stat = "identity") + theme(axis.text.x=element_text(angle=60,hjust=1)) + labs(x="Major", y="Recent vs. All bachelor graduates: Earning difference")
  })
  
  #Bar graph showing difference in earnings between bachelor vs graduate degree holders
  output$gradCompare <- renderPlot({
    if(input$Major_Category == 'Agriculture & Natural Resources') {
      plot.df <- df %>% filter(Major_Category == 'Agriculture & Natural Resources')
    } else if(input$Major_Category == 'Arts') {
      plot.df <- df %>% filter(Major_Category == 'Arts')
    } else if(input$Major_Category == 'Biology & Life Science') {
      plot.df <- df %>%filter(Major_Category == 'Biology & Life Science')
    } else if(input$Major_Category == 'Business') {
      plot.df <- df %>% filter(Major_Category == 'Business')
    } else if(input$Major_Category == 'Communications & Journalism') {
      plot.df <- df %>% filter(Major_Category == 'Communications & Journalism')
    } else if(input$Major_Category == 'Computers & Mathematics') {
      plot.df <- df %>% filter(Major_Category == 'Computers & Mathematics')
    } else if(input$Major_Category == 'Education') {
      plot.df <- df %>% filter(Major_Category == 'Education')
    } else if(input$Major_Category == 'Engineering') {
      plot.df <- df %>% filter(Major_Category == 'Engineering')
    } else if(input$Major_Category == 'Health') {
      plot.df <- df %>% filter(Major_Category == 'Health')
    } else if(input$Major_Category == 'Humanities & Liberal Arts') {
      plot.df <- df %>% filter(Major_Category == 'Humanities & Liberal Arts')
    } else if(input$Major_Category == 'Industrial Arts & Consumer Services') {
      plot.df <- df %>% filter(Major_Category == 'Industrial Arts & Consumer Services')
    } else if(input$Major_Category == 'Interdisciplinary') {
      plot.df <- df %>% filter(Major_Category == 'Interdisciplinary')
    } else if(input$Major_Category == 'Law & Public Policy') {
      plot.df <- df %>% filter(Major_Category == 'Law & Public Policy')
    } else if(input$Major_Category == 'Physical Sciences') {
      plot.df <- df %>% filter(Major_Category == 'Physical Sciences')
    } else if(input$Major_Category == 'Psychology & Social Work') {
      plot.df <- df %>% filter(Major_Category == 'Psychology & Social Work')
    } else if(input$Major_Category == 'Social Science') {
      plot.df <- df %>% filter(Major_Category == 'Social Science')
    }  
    ggplot(plot.df, aes(x = Major, y = Median_difference_rgc)) + geom_bar(stat = "identity") + theme(axis.text.x=element_text(angle=60,hjust=1)) + labs(x="Major", y="Bachelor vs. Graduate: Earning Difference")
  })
  
  #Scatter plot showing female share in earnings compared to overall earning
  output$femaleShare <- renderPlot ({
    if(input$Major_Category == 'Agriculture & Natural Resources') {
      plot.df <- df %>% filter(Major_Category == 'Agriculture & Natural Resources')
    } else if(input$Major_Category == 'Arts') {
      plot.df <- df %>% filter(Major_Category == 'Arts')
    } else if(input$Major_Category == 'Biology & Life Science') {
      plot.df <- df %>%filter(Major_Category == 'Biology & Life Science')
    } else if(input$Major_Category == 'Business') {
      plot.df <- df %>% filter(Major_Category == 'Business')
    } else if(input$Major_Category == 'Communications & Journalism') {
      plot.df <- df %>% filter(Major_Category == 'Communications & Journalism')
    } else if(input$Major_Category == 'Computers & Mathematics') {
      plot.df <- df %>% filter(Major_Category == 'Computers & Mathematics')
    } else if(input$Major_Category == 'Education') {
      plot.df <- df %>% filter(Major_Category == 'Education')
    } else if(input$Major_Category == 'Engineering') {
      plot.df <- df %>% filter(Major_Category == 'Engineering')
    } else if(input$Major_Category == 'Health') {
      plot.df <- df %>% filter(Major_Category == 'Health')
    } else if(input$Major_Category == 'Humanities & Liberal Arts') {
      plot.df <- df %>% filter(Major_Category == 'Humanities & Liberal Arts')
    } else if(input$Major_Category == 'Industrial Arts & Consumer Services') {
      plot.df <- df %>% filter(Major_Category == 'Industrial Arts & Consumer Services')
    } else if(input$Major_Category == 'Interdisciplinary') {
      plot.df <- df %>% filter(Major_Category == 'Interdisciplinary')
    } else if(input$Major_Category == 'Law & Public Policy') {
      plot.df <- df %>% filter(Major_Category == 'Law & Public Policy')
    } else if(input$Major_Category == 'Physical Sciences') {
      plot.df <- df %>% filter(Major_Category == 'Physical Sciences')
    } else if(input$Major_Category == 'Psychology & Social Work') {
      plot.df <- df %>% filter(Major_Category == 'Psychology & Social Work')
    } else if(input$Major_Category == 'Social Science') {
      plot.df <- df %>% filter(Major_Category == 'Social Science')
    } 
    ggplot(plot.df, aes(x=female_share, y=median_earnings_overall, color=Major_Category)) +geom_point() + theme(axis.text.x=element_text(angle=60,hjust=1)) + labs(x="Female Share", y="Median Earnings Overall")
  })
  
})

