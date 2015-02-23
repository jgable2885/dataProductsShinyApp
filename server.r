library(shiny)
set.seed(500)
generateData <- function(d, n, mu=0, sd=1) {
	if(d == "ed")
	{
		y <- rexp(n, 1/mu)
	}
	else if(d == "zd")
	{
		y <- rnorm(n, mu, sd)
	}
	else if(d == "pd")
	{
		y <- rpois(n, mu)
	}
	y
}
shinyServer(
        function(input, output){
                output$osd1 <- renderPrint({input$sd1})
                output$osd2 <- renderPrint({input$sd2})
                output$omean1 <- renderPrint({input$mean1})  
                output$omean2 <- renderPrint({input$mean2}) 
                output$otest <- renderPrint({input$test})   
                output$odist <- renderPrint({input$dist})
                output$on <- renderPrint({input$n}) 
                
                
                output$dataPlot <- renderPlot({
                	y1 <- generateData(input$dist, input$n, mu=input$mean1, sd=input$sd1)
               	    y2 <- generateData(input$dist, input$n, mu=input$mean2, sd=input$sd2)
                	overallMin <- min(c(y1,y2))
                	overallMax <- max(c(y1,y2))
                	p1 <- hist(y1)
                	p2 <- hist(y2)
    				plot(p1, col=rgb(0,1,0,1/4), xlim=c(overallMin, overallMax))
    				plot(p2, col=rgb(0,0,1,1/4), add=T,xlim=c(overallMin, overallMax))
                })
                
                computeStats <- reactive({
                	set.seed(500)
                	y1 <- generateData(input$dist, input$n, mu=input$mean1, sd=input$sd1)
               	    y2 <- generateData(input$dist, input$n, mu=input$mean2, sd=input$sd2)
               	    pooledSd <- sqrt(((input$n-1)*sd(y1)^2+(input$n-1)*sd(y2)^2)/(2*input$n-2))
               	    tresult <- t.test(y1,y2)$p.value
               	    zs <- (mean(y1)-mean(y2))/(pooledSd/sqrt(input$n)) 
               	    zresult <- 2*pnorm(-abs(zs)) 
                	result <- c(tresult, zresult)
                })
          		output$tresult <- renderPrint({computeStats()[1]})
          		output$zresult <- renderPrint({computeStats()[2]})
            
                                
        }
)