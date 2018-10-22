# Define server logic required to draw a histogram 
library(ggplot2)
library(dplyr)

shinyServer(function(input, output, session) {
    
    output$GDPPlot <- renderPlot({
        
        #Obtain the min and max year from the slider 
        year_min <- min(input$yr_range) 
        year_max <- max(input$yr_range) 
        
        #Import our two datasets for info tech
        gdp_info_tech_TAA_CNST_ICT <- read.csv("gdp_info_tech_TAA_CNST_ICT.csv")
        gdp_info_tech_TAA_CNST_ICTS <- read.csv("gdp_info_tech_TAA_CNST_ICTS.csv")
        
        # Get the date range to isolate for certain time period
        gdp_info_tech_TAA_CNST_ICT <- subset(gdp_info_tech_TAA_CNST_ICT, year %in% year_min:year_max)
        gdp_info_tech_TAA_CNST_ICTS <- subset(gdp_info_tech_TAA_CNST_ICTS, year %in% year_min:year_max) 
        
        # Render the graphs based on the checkbox
        if (input$choose_ict && input$choose_icts){ 
            ggplot() + 
                geom_line(data=gdp_info_tech_TAA_CNST_ICT, 
                          aes(x=year, y=mean,group = 1), color="blue") + 
                geom_line(data=gdp_info_tech_TAA_CNST_ICTS, 
                          aes(x=year, y=mean,group = 1), color="red") + 
                xlab("Date")+ 
                ylab("GDP Value (in millions)")
        
        } else if(input$choose_icts){ 
            ggplot() +
            geom_line(data=gdp_info_tech_TAA_CNST_ICTS, 
                     aes(x=year, y=mean,group = 1), color="red") + 
                xlab("Date")+ 
                ylab("GDP Value (in millions)")
        }else if(input$choose_ict){
                ggplot() + 
                geom_line(data=gdp_info_tech_TAA_CNST_ICT, 
                              aes(x=year, y=mean,group = 1), color="blue") + 
                xlab("Date")+ 
                ylab("GDP Value (in millions)")
        }
    })
}) 