#rm(list=ls()) #clears variables
#cat("\014") #clears console || ctrl+L also works 
#getwd()
#setwd()

# DataFrame Cleaning #####################################################################################################################################
library(readr)
file <- "~/GitHub/HeroRotation/HotsData - Rotation.csv"
DFA <- read_csv(file)  
  
#column organization
ignoreC <- 23 #this can change
chunk3 <- 94-5 #this can change
chunk2 <- 66
chunk1 <- 26
#row organization, # of each class WILL change
warrior <- 21
assassin <- 34
support <- 16
specialist <- 12
multiclass <- 1
#newest hero index (has not been free for the 1st time)
bad <- 44 #row number in DF, (not DFA) #who: orphea

indexC_remove <- -1*c(2:(1+ignoreC),1+ignoreC+chunk3+1,1+ignoreC+chunk3+1+chunk2+1,1+ignoreC+chunk3+1+chunk2+1+chunk1+1)
#change bottom indexC_remove with new role system
indexC_remove <- c(-1:-18,-20:-24,-114,-181,-208) #################################################################################OLD ROLE SYSTEM
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

par(mfrow=c(3,3))
#Analysis ###############################################################################################################################################

as.numeric(DF[1,2:ncol(DF)]) #vector of 0/1s
colnames(DF)
as.Date("2/20/2018","%m/%d/%Y")
#library(lubridate) #look at lubridate package for more formatting ~ equivalently, I use hms package
#library(hms)

#List of Weeks as Date opbjects
weeks_str <- colnames(DF)[-1]
weeks <- as.Date(weeks_str[1],"%m/%d/%Y") #initalize
for(i in 2:length(weeks_str)){
  weeks <- c(weeks,as.Date(weeks_str[i],"%m/%d/%Y"))
}
weeks <- rev(weeks)

for(name in 1:nrow(DF)){ #looping over all characters
if(name==bad){next}
#finding the index when the character is 1st on free rotation
entries <- as.numeric(DF[name,2:ncol(DF)])
entries <- rev(entries)
first_free <- 1
is_free <- as.logical(entries[first_free])
while(!is_free){
  first_free = first_free+1
  is_free <- as.logical(entries[first_free])
}
first_free
weeks[first_free]

#date vs weeks since last on rotation
diff<- rep(NA,length(entries))
index <- 0
for(i in first_free:length(entries) ){
  if(entries[i]==0){ #counting how many weeks not on rotation
    index = index+1
  } else if(entries[i]==1){ #sets how many weeks not on rotation, resets counting index
    diff[i] = index+1
    index = 0
  }
}
diff[first_free] <- 0 #first time they are avlaible on rotation
title <- sprintf('%s Free Rotation',DF[name,1])
plot(weeks,diff,main=title,ylab='Weeks Since Last Avalaible on Free Rotation',las=1)
abline(v=as.Date('12/8/2015',"%m/%d/%Y"),col='red',lw=1,lty=3) #rotation increased from 7->10
abline(v=as.Date('3/14/2017',"%m/%d/%Y"),col='blue',lw=1,lty=3) #rotation increased from 10->14
#legend("bottomleft",inset=.05,c('Rotation increased from 7->10','Rotation increased from 7->10'),fill=c('red','blue'))
}
par(mfrow=c(1,1))
















# scrapped analysis #########################################################################################################################

#look into date vs count graph
#plot(weeks,as.numeric(DF[1,2:ncol(DF)])) #plots weeks vs when they were free- not a good data visualization tool

#date vs cumulitive counts (if there is a pattern, should be straight line, if not then should look like scattered line)
#as.numeric()
# cum_sum <- rep(0,length(entries))
# for(i in 0:(length(entries)-1) ){
#   cum_sum[i+1] <- sum(entries[1:(1+i)]) #cum sum from 1 to ith
# }
# cum_sum
# entries
# plot(weeks,cum_sum)
