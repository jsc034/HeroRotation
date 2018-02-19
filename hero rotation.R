#rm(list=ls()) #clears variables
#cat("\014") #clears console || ctrl+L also works 
#getwd()
#setwd()
library(readr)

file <- "~/GitHub/HeroRotation/HotsData - Rotation.csv"
DFA <- read_csv(file)  
  
#column organization
ignoreC <- 15 #this can change
chunk3 <- 49 #this can change
chunk2 <- 66
chunk1 <- 26

indexC_remove <- -1*c(2:(1+ignoreC),1+ignoreC+chunk3+1,1+ignoreC+chunk3+1+chunk2+1,1+ignoreC+chunk3+1+chunk2+1+chunk1+1)
indexR_remove <- -1*c(20,52,67,80,82:nrow(DFA))
DF <- DFA[indexR_remove,indexC_remove] #more compact version of dataframe I am working with, removed empty columns at begining & count columns
#a <-c(2:ignoreC,1+ignoreC+chunk3+1,1+ignoreC+chunk3+1+chunk2+1,1+ignoreC+chunk3+1+chunk2+1+chunk1+1)






