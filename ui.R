#install.packages("shiny")
library("shiny")


shinyUI(fluidPage(    
  
  # Give the page a title
  titlePanel("Exploring the Relationship between College Majors and Earnings"),
  
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
                  tabPanel("Recent Grad Earning Comparison", plotOutput("recentGrad"),
                           tags$body(p("The graph shows the median earnings of recent bachelor graduates (age<28) from both the 
                                        2010-2012 data and 2012-2016 data. Interestingly, the median earnings have generally 
                                        decreased over time. The magnitude of the decrease is even greater than presented, as 
                                        inflation was not considered for the analysis."),
                                     p("A possible explanation is that in recent years, there is a greater number of students 
                                        graduating with bachelor's degree, concentrating the job market. Hence, higher number of 
                                        students choose to pursue higher education to maintain the competitive edge."),
                                     p("One interesting major to look at is Petroleum Engineering. In 2012, it was ranked first 
                                        in terms of median earnings but in 2016, it has decreased significantly (albeit still 
                                        being in the top pack), which reflects the volatility of the industry. This informs students 
                                        that the median earnings should be looked at in conjunction with other factors such as risk 
                                        premiums or working conditions when choosing a major."))),
                  tabPanel("Earning Growth", plotOutput("earningGrowth"),
                           tags$body(p("The graph depicts the difference in earnings between recent bachelor graduates (age<28) and 
                                        those of all age with only a bachelor degree. It intends to show the earnings growth potential 
                                        for each major when higher education was not pursued."),
                                     p("Often, the salary received right upon graduation does not accurately forecast future income. 
                                        It is important to note that majors in certain fields such as Engineering tend to have much 
                                        steeper earnings curve than for example, Humanities and Liberal Arts"))),
                  tabPanel("Degree Earning Comparison", plotOutput("gradCompare"),
                           tags$body(p("The graph illustrates the difference in median earnings between those with only a bachelor's 
                                        degree and those with higher degrees (master's, doctorate, etc). Similar to the Earnings Growth 
                                        graph, certain majors are more sensitive to these 'graduate school premium'. Generally, STEM 
                                        majors tend to benefit more from a graduate degree, but pre-med and pharmaceutical majors stand 
                                        out as the top."))),
                  tabPanel("Female Earning", plotOutput("femaleShare"),
                           tags$body(p("The graph was produced to determine whether there is any correlation between gender and earnings. 
                                        It plots every major's median earnings versus the percentage of females in that major."),
                                     p("The graph depicts that there is an inverse correlation, meaning that the majors with higher 
                                        percentage of females tend to have lower median earnings. The exception to the trend is in the 
                                        field of Health, in which the females often have shares higher than 50%. Note that the graph does 
                                        not necessarily imply that a causal relationships exists between the two factors, but rather just 
                                        hints at the existence of correlation."))),
                  tabPanel("Recent Grad Earnings Table 2012-2016", tableOutput("table"))
      )
    )
  )
))




