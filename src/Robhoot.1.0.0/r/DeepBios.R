Rversion <- R.Version()
Rversion$version.string
## "R version 4.0.3 (2020-10-10)"


rm(list=ls())
getwd()
dir()

setwd("C:/Paco/GitHub/Deepbios/src")
dir()

library(dplyr)


DB <- read.csv("DB.csv")


# Filter
DB <- DB[!((DB$HaulVal == 'I') & !(DB$Survey == 'SP-NORTH') & !(DB$Survey == 'SP-PORC')),]
DB <- DB[!(DB$HLNoAtLngt == -9),]
DB <- DB[!(DB$HaulDur == 0),]
DB <- DB[!(DB$HaulDur > 200),]

# Standardization
for (c in 1:nrow(DB)){
    if (DB$DataType[c] == 'C')
        DB$CPUE_number_per_hour[c] <- DB$HLNoAtLngt[c]
    else 
        DB$CPUE_number_per_hour[c] <- (DB$HLNoAtLngt[c]*60)/DB$HaulDur[c]
}


# Structure
str(DB)
summary(DB)


write.table(DB,"DBa.csv",
            sep=",",dec=".",col.names=NA)
