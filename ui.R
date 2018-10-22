library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
   
   # Application title
   titlePanel("Information and communication technology contribution to GDP in Canada"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      # Sidebar panel will consist of year/date range
      sidebarPanel(
         sliderInput("yr_range", "Year range:",
                     min = 2007, max = 2018,
                     value = c(2007,2018), 
                     sep = "", 
                     ticks = FALSE),
         p(strong("Choose a dataset to display:")),
         checkboxInput(inputId="choose_ict", 
                       label="Information and communication technology sector (Blue)", value = TRUE), 
         checkboxInput(inputId="choose_icts", 
                       label="Information and communication technology, services (Red)", value = FALSE)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("GDPPlot")
      )
   )
))

