#we will be talking about data frames
#lets import some data and store it in raw data folder (destfile)
download.file(url = "https://ndownloader.figshare.com/files/2292169",
              destfile = "data_raw/portal_data_joined.csv")

library(tidyverse)

surveys <- read_csv("data_raw/portal_data_joined.csv") #read the data into environment and store it as "surveys"

head(surveys) #shows first six rows

View(surveys) #shows the whole table in a separate tab

str(surveys) #shows structure of the data frame

dim(surveys) #shows dimentions of the table
nrow(surveys) #shows number of rows
ncol(surveys) #shows number of columns

names(surveys) #gives us names of columns
rownames(surveys) #gives names of rows

summary(surveys) #computes summary stats for columns

#Indexing and subsetting
surveys[1, 6] #first row, six columns

surveys[1, ]#extracts first row
surveys[, 1] #extracts first column

surveys [c(1, 2, 3), c(5,6)] #extracts rows 1,2,3 and columns 5,6
surveys[1:3, 5:6] #does the same

surveys[, -1] #removes the first column

surveys[, "sex"] #shows me the column "sex"
surveys$plot_id #shows the content of the specified column

surveys_200 <- surveys[200, ] #extracts only the row 200
surveys[nrow(surveys), ] #extracts the last row
