library(qdap)

# Make sure the positions of the text you want to fidn and replace match up otherwise you'll produce nonsense
toFind <- c("'","’","€","≤","≥","°", "–", "±","×" )
toReplace <- c("'","'","&#8364 ", "&#8804 ", "&#8805 ", "&deg ", "-", "+-", "x")

Fix <- data.frame(toFind, toReplace, stringsAsFactors=FALSE)

filesToClean <- list.files(path = "ToClean/", pattern="*.csv")

for (myFile in filesToClean) {

  # Load the data
  #Introduction <- read.csv("ToClean/Introduction.csv",stringsAsFactors = FALSE)
  myDF <- read.csv(paste("ToClean/",myFile, sep = ""),stringsAsFactors = FALSE)
  
  #myDF <- Introduction
  myDFClean <- myDF
  
  # There is probably a better way to do this using vectors...
  for (myCol in colnames(myDF)){
    

    print(paste("Processing",myCol,"in", myFile))
    
    # Do a find and replace using mgsub from the qdap package
    myDFClean[,myCol] <- mgsub(Fix$toFind, Fix$toReplace, myDF[,myCol] )
    
    SplitText <- unlist(strsplit(as.character(myDF[,myCol]), split = " "))
    SplitTextClean <- unlist(strsplit(as.character(myDFClean[,myCol]), split = " "))
    
    # Check the "before" file for non-ascii characters
    myGResults <- grep("[^\\x00-\\x7F]", SplitText, perl=T)
    if(length(myGResults)>0){
      print("Now showing non-ascii characters before cleaning")
      print(SplitText[myGResults])
    } else {
      #print("No non-ascii characters found before cleaning")
    }
    
  
    # Check the "before" file for non-ascii characters
    myGResults <- grep("[^\\x00-\\x7F]", SplitTextClean, perl=T)
    if(length(myGResults)>0){
      print("Now showing remaining non-ascii characters after cleaning")
      print(SplitTextClean[myGResults])
    } else {
      #print("No non-ascii characters found after cleaning")
    }
    

  }
  
  # Save the cleaned files
  write.csv(myDFClean,paste("Cleaned/", myFile, sep = ""))

}





