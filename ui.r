library(shiny)
shinyUI(pageWithSidebar(
        headerPanel("Comparing test statistics when you know the 'truth'"),
        sidebarPanel(
                h3('Welcome'),
                h4('This app compares the on p-value of assuming normality and assuming a t-distribution
                   choosing different true underlying distributions (e.g.
                   what is the effect of using a Z test on data that are actually
                   Poisson)'),
                h4('Below, select a true distribution, standard deviation
                   for each data set, mean for each data set, and number of points'),
                selectInput('dist', "Choose the true distribution of the datasets:", choices = c('Normal' = 'zd', 
                                                                                                 'Poisson' = 'pd', 'Exponential'='ed')),
                numericInput('mean1', 'Mean of dataset 1', value=0, min=0, step=0.1),
                numericInput('sd1', 'Standard deviation of dataset 1', 1, min = 0, max = 10, step = 0.1),
                numericInput('mean2', 'Mean of dataset 2', value=0, min=0, step=0.1),
                numericInput('sd2', 'Standard deviation of dataset 2', 1, min = 0, max = 10, step = 0.1),
                numericInput('n', 'Numer of points in each dataset', value=10, min=1, max=1000, step=1)
                
                
                ),
        mainPanel(
                h3('Main Panel text'),
                plotOutput("dataPlot"),
                h4('The p-value using a two-sample unpaired t-test is:'),
                verbatimTextOutput("tresult"),
                h4('The p-value using a two sample Z statistic assuming independence and pooled variance is:'),
                verbatimTextOutput("zresult"),
                h4('Standard deviation of dataset 1'),
                verbatimTextOutput("osd1"),
                h4('Mean of dataset 1'),
                verbatimTextOutput("omean1"),
                h4('Standard deviation of dataset 2'),
                verbatimTextOutput("osd2"),
                h4('Mean of dataset 2'),
                verbatimTextOutput("omean2"),
                #h4('Test'),
                #verbatimTextOutput("otest"),
                #h4('Underlying distribution'),
                #verbatimTextOutput("odist")
                h4('Numer of points'),
                verbatimTextOutput("on")
                
        )
        
))