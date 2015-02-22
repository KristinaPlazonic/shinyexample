library(datasets)

shinyServer(
  function(input, output){
    mydata <- reactive({
      switch(input$datachoice,
           #  "g" = galton$child,
             "n" = nottem,
             "s" = sunspots,
             "f" = faithful$eruptions, 
             "e" = eurodist)
    })
    mydescription = reactive({
      switch(input$datachoice,
            # "g" = "the heights of 928 men, measured in inches", 
             "n" = "the average monthly temperatures at Nottingham for 240 months in 1920-1939", 
             "s" = "the number of monthly sunspots for 2820 months in 1749-1983", 
             "f" = "the 272 measurements of duration of eruptions of Old Faithful geyser",
             "e" = "the 210 distances between European cities")
    })
    n = reactive({ input$n })
    m = reactive({ input$m })
    mu = reactive({        mean(mydata())     })
    s = reactive({         sd(mydata())         })
    fsample = reactive({     sample(mydata(),input$n)     })
    #fsample_mean = mean(fsample())
    #fsample_sd = sd(fsample())
    output$pop_mean <- renderText({  round(mu(), 2)   })
    output$pop_sd <- renderText({round(s(),2)})
    output$sample_size <- renderText({   n() })
    output$m <- renderText({   m()    }) 
    output$description <- renderText({   mydescription()   })
    output$fsample <- renderPrint({    fsample()   })
    output$fsample_mean <- renderText({   mean(fsample())  })
    #output$sample_sd <- renderText({   fsample_sd()  })
    output$original_data_histogram <- renderPlot({
      hist(mydata(), main = mydescription(), xlab=paste("mean=", round(mu(), 3)))
      abline(v = mu(), col= "red", lwd = 2)
    })
    
    sampling = reactive({ 
      apply(matrix(
        sample(mydata(), 1000*input$n, replace = TRUE), 
        1000,input$n), 
        1, mean) 
    })
    
    output$samplingPlot = renderPlot({
      hist(sampling()[1:input$m], main="", 
           xlab = paste("Theoretical sigma=", round( s()/sqrt(input$n),4 ), 
                        "actual sigma = ",  sd( sampling()[1:input$m] )))
      abline(v = mu(), col= "red", lwd = 2)
    })
  }
)

#### shinydir = "/home/kris/learning/coursera/dev_data_products_course9/shiny"