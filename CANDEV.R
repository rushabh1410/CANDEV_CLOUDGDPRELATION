library(CANSIM2R) 
library(dplyr)
library(ggplot2)

gdp_raw <- getCANSIM(36100434, raw=TRUE)
names(gdp_raw)[6] <- paste("NAICS")
names(gdp_raw)

gdp_industry <- unique(gdp_raw[6]) 

# Things to filter out (except for manufacturing)
#Information and communication technology sector
#Information and communication technology, manufacturing
#Information and communication technology, services
industry_to_filter <- c("Information and communication technology sector", "Information and communication technology, services")
gdp_info_tech <- gdp_raw %>% filter(NAICS %in% industry_to_filter & !is.na(VALUE))

#Get only the necessary data  
# COLUMNS PRESENT: 
# REF_DATE 
# Seasonal.adjustment 
# Prices 
# NAICS 
# VALUE
gdp_info_tech <- select(gdp_info_tech,REF_DATE,Seasonal.adjustment,
                        Prices,NAICS,VALUE)

# There are four combinations based on seasonal_adjustment and prices 
# Abbreviations: 
# Seasonal Adjustment: 
# Seasonally adjusted at annual rates SAAA
# Trading-day adjusted TAA
#
# Prices: 
# Chained (2007) dollars CH
# 2007 constant prices CNST  
# 
# NAICS: 
#Information and communication technology sector ICT
#Information and communication technology, services ICTS


gdp_info_tech_SAAA_CH_ICT <- gdp_info_tech %>% filter(Seasonal.adjustment == "Seasonally adjusted at annual rates" 
                                                      & Prices == "Chained (2007) dollars" 
                                                      & NAICS == "Information and communication technology sector")

gdp_info_tech_SAAA_CH_ICTS <- gdp_info_tech %>% filter(Seasonal.adjustment == "Seasonally adjusted at annual rates" 
& Prices == "Chained (2007) dollars" 
& NAICS == "Information and communication technology, services")

gdp_info_tech_SAAA_CNST_ICT <- gdp_info_tech %>% filter(Seasonal.adjustment == "Seasonally adjusted at annual rates" 
                                                        & Prices == "2007 constant prices" 
                                                        & NAICS == "Information and communication technology sector")
gdp_info_tech_SAAA_CNST_ICTS <- gdp_info_tech %>% filter(Seasonal.adjustment == "Seasonally adjusted at annual rates" 
                                                         & Prices == "2007 constant prices" 
                                                         & NAICS == "Information and communication technology, services")


gdp_info_tech_TAA_CNST_ICT <- gdp_info_tech %>% filter(Seasonal.adjustment == "Trading-day adjusted" 
& Prices == "2007 constant prices" 
& NAICS == "Information and communication technology sector")
gdp_info_tech_TAA_CNST_ICTS <- gdp_info_tech %>% filter(Seasonal.adjustment == "Trading-day adjusted" 
                                                        & Prices == "2007 constant prices" 
                                                        & NAICS == "Information and communication technology, services")

gdp_info_tech_SAAA_CH_ICTS <- select(gdp_info_tech_SAAA_CH_ICTS,REF_DATE,VALUE)

#Separate the data into year and month 
subset_year <- function(text){return(strtrim(text,4))}
subset_month <- function(text){return(substring(text,6,8))}
gdp_info_tech_SAAA_CH_ICTS$year <- sapply(gdp_info_tech_SAAA_CH_ICTS$REF_DATE, FUN =subset_year)
gdp_info_tech_SAAA_CH_ICTS$month <- sapply(gdp_info_tech_SAAA_CH_ICTS$REF_DATE, FUN =subset_month)
write.csv(x = gdp_info_tech_SAAA_CH_ICTS, file = "gdp_info_tech_SAAA_CH_ICTS.csv")


#graph <- ggplot() +
#    geom_line(data=gdp_info_tech_SAAA_CH_ICT, aes(x=REF_DATE, y=VALUE,group = 1), color="blue") + 
 #   geom_line(data=gdp_info_tech_SAAA_CH_ICTS, aes(x=REF_DATE, y=VALUE,group = 1), color="red")

