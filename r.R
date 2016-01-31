###############################################################################################################################
#FUNDAMENTAL ANALYSIS
###############################################################################################################################
#Load of stock symbols csv
setwd(".")
dfEntireSGXSymbols <- read.csv("SGXSymbols.txt")

#Load require tag
szTag = "snl1b4x"

#Combing of information from yahoo finance
fnCombInfo <- function(x) {
  sztemp <- paste0("http://download.finance.yahoo.com/d/quotes.csv?s=",x,"&f=", szTag,"&e=.csv")
  sztemp <- read.csv(sztemp,header=FALSE)
  return(data.frame(Symbol = sztemp[1], CoyName = sztemp[2], Price = sztemp[3], BookValue = sztemp[4], StockExchange=sztemp[5]))
}
lCombedData <- apply(dfEntireSGXSymbols,1, fnCombInfo)

#Dirty and ugly of converting list into data.frame
#Placeholder for combed info
dfCombInfo <- data.frame(Symbol = character(), CoyName = character(), Price = numeric(), BookValue = numeric(), StockExchange=character())
for (eleCombedData in lCombedData){
  names(eleCombedData) <- c("Symbol","CoyName","Price","BookValue","StockExchange")
  dfCombInfo <- rbind(dfCombInfo, eleCombedData)
}

#Print of combed data
dfCombInfo[order(dfCombInfo$Price),]

#Summary of price
summary(dfCombInfo$Price)

#Analysis by grouping exchange
tapply(dfCombInfo$Price, dfCombInfo$StockExchange, mean)

#Book value > Price
dfCombInfo[dfCombInfo$BookValue > dfCombInfo$Price, ]

#Write into csv ?write.csv
write.csv(dfCombInfo, file="History.csv", row.names=FALSE)

###############################################################################################################################
#TECHNICAL ANALYSIS
###############################################################################################################################
#install.packages("quantmod")
library('quantmod')

# Draw graph
getSymbols("AAPL")
chartSeries(AAPL, subset='last 3 months')
addBBands()

#Show head & tail
print(paste0("Total Records: ", nrow(AAPL)))
head(AAPL,2)
tail(AAPL,4)