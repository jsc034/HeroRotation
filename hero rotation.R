#rm(list=ls()) #clears variables
#cat("\014") #clears console || ctrl+L also works 
#getwd()
#setwd()
library(readr)

file <- "~/GitHub/HeroRotation/HotsData - Rotation.csv"
DFA <- read_csv(file)  
  
#column organization
ignoreC <- 14 #this can change
chunk3 <- 50 #this can change
chunk2 <- 66
chunk1 <- 26
#row organization, # of each class WILL change
warrior <- 19
assassin <- 31
support <- 14
specialist <- 12
multiclass <- 1
indexC_remove <- -1*c(2:(1+ignoreC),1+ignoreC+chunk3+1,1+ignoreC+chunk3+1+chunk2+1,1+ignoreC+chunk3+1+chunk2+1+chunk1+1)
indexR_remove <- -1*c(warrior+1,warrior+1+assassin+1,warrior+1+assassin+1+support+1,warrior+1+assassin+1+support+1+specialist+1,(warrior+1+assassin+1+support+1+specialist+1+multiclass+1):nrow(DFA))
DFB <- DFA[indexR_remove,indexC_remove] #more compact version of dataframe I am working with: removed seperating rows & empty columns at begining & count columns
#a <-c(2:ignoreC,1+ignoreC+chunk3+1,1+ignoreC+chunk3+1+chunk2+1,1+ignoreC+chunk3+1+chunk2+1+chunk1+1)
DF <- DFB
for(i in 1:nrow(DF)){
  for(j in 2:ncol(DF)){
    if( is.na(DF[i,j]) ){ DF[i,j] <- 0
    } else{ DF[i,j] <- 1}
  }
}
#look into date vs count graph
#date vs cumulitive counts (if there is a pattern, should be straight line, if not then should look like scattered line)
#as.numeric()



