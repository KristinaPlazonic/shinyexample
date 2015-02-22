shinyUI(pageWithSidebar(
  headerPanel("Illustrating the Central Limit Theorem on 4 different real life datasets"), 
  sidebarPanel(
    radioButtons("datachoice", 
                 label = p("Choose dataset from which sample will be drawn"), 
                 choices = list(#"galton (normal)" = "g", 
                                "nottem (uniform)" = "n", 
                                "sunspots (exponential)" = "s",
                                "faithful (bimodal)" = "f", 
                                "eurodist (skewed)" = "e"), 
                 selected = "s"
                 ),
    
    br(), br(), br(), br(), br(), br(),
    br(), br(), br(), br(), br(), br(),
    br(), br(), br(), br(), br(), br(),
    sliderInput("n", label = p("Size of the sample to be drawn from the chosen dataset"), value = 30, 
                min = 2, max = 100, step = 2),
    h5("The bigger the size of the sample, the more the sampling distribution of the mean is going to 
      resemble the normal distribution, and the narrower will the sampling distribution be."),
    
    br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(), br(),
    
    sliderInput("m", label = p("Number of samples to be drawn from the chosen dataset"), value = 1000, 
                min = 100, max = 1000, step = 100), 
    h5("The bigger the number of samples, the more points we are plotting in the histogram of the 
       sampling distribution")
  ),  # end of sidebarPanel

  mainPanel(
    p("In this app, we will illutrate the Central Limit Theorem. This is the
      most important concept of statistics, but sometimes really hard to wrap
      your head around."),
    p("The basic premise is that no matter which 
      probability distribution your data follows, the distribution of the
      sample means will become approximately normal, with the mean equal
      to the population mean and standard deviation depending on the 
      size of the sample (but decreasing with the size)."),
    
    span("You have chosen the dataset of "), textOutput("description", inline = TRUE),
    span("Population mean of the dataset is "), textOutput("pop_mean", inline = TRUE),
    span("and the standard deviation is "), textOutput("pop_sd", inline = TRUE), 
    span("Note the distribution of this dataset."),
    plotOutput("original_data_histogram"), 
    
    h3("Results"),
    p("To get a sense of what is being plotted in the output histogram, 
      here is an example of a sample you took from the plotted population"),
    verbatimTextOutput("fsample"),
    span("This sample has a mean of ") , textOutput("fsample_mean", inline = TRUE),
    
    span("As you can see, you have chosen to deal with samples of size "), 
    textOutput("sample_size", inline = TRUE),
    
    p("Now, crucially, we take a number such samples (and their means).
      The Central Limit Theorem tells us that the resulting histogram should approximate the
      normal distribution with the same mean as original population, but with standard deviation
      that is divided by the square root of the sample size. This is the theoreoretical sigma in 
      histogram."),
    span("You chose to plot a histogram of "), textOutput("m", inline = TRUE), 
    span("such means. Change the sample size to see the standard deviation of the sample mean decrease."), 
    plotOutput("samplingPlot")
  )  # end of mainPanel
))