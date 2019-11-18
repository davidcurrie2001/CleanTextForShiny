library(qdap)


# Make sure the positions of the text you want to fidn and replace match up otherwise you'll produce nonsense
toFind <- c("'","€","≤","≥","°", "–" )
toReplace <- c("‘","&#8364 ", "&#8804 ", "&#8805 ", "&deg ", "-")

Fix <- data.frame(toFind, toReplace, stringsAsFactors=FALSE)

# Load the data
Introduction <- read.csv("Introduction.csv",stringsAsFactors = FALSE)

myDF <- Introduction
myDFClean <- Introduction

# There is probably a better way to do this using vectors...
for (myCol in colnames(Introduction)){
  
  #myCol <- colnames(Introduction)[[2]]
  #myDF[,myCol]
  
  # Do a find and replace using mgsub from the qdap package
  myDFClean[,myCol] <- mgsub(Fix$toFind, Fix$toReplace, myDF[,myCol])
    
}


write.csv(myDFClean,"Introduction_clean.csv")


#SplitText <- unlist(strsplit(Introduction$X2018, split = " "))
# https://stackoverflow.com/questions/37843545/how-to-determine-if-character-string-contains-non-roman-characters-in-r
#SplitTextNonAscii <- grep("SplitText", iconv(SplitText, "latin1", "ASCII", sub="SplitText"))
#library(tools)
#showNonASCII(Introduction$X2018)


