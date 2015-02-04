library(MASS)

#creating variables
a<-59
b<-55
c<-53.5
d<-55
e<-52.5
Wing1<-a
Wing2<-b
Wing3<-c
Wing4<-d
Wing5<-e

#use functions with variables
sqrt(Wing1)
2*Wing1

#store an arithmetic function as a new variable
SQ.Wing1<-sqrt(Wing1)

#c is the combine function
Wingcrd<-c(59,55,53,55,52.5,57.5,53,55)
Wingcrd

#access a particular value stored in a variable
Wingcrd[1] #returns the first value
Wingcrd[1:5] #returns the first five value
Wingcrd[-2] #returns every value except the second
Tarsus<-c(22.3, 19.7, 20.8, 20.3, 20.8, 21.5,20.6,21.5)
Head<-c(31.2,30.4,30.6,30.3,30.3,30.8,32.5,NA)
Wt<-c(9.5,13.8,14.8,15.2,15.5,15.6,15.6,15.7)
#note that sum(Head) doesn't work because it contains a NA
#use the remove function to compute the sum without the NA
sum(Head, na.rm=TRUE)

#useful functions
#mean(), max(), max(), median(), summary()

#use rep (replicate) and seq (sequence) functions to create sets/matrices
ID<-rep(1:4,each=8)
ID #this returns each number from 1 to 4, 8 times
f<-seq(from=1,to=4,by=1)
f

#cbind function puts things into columns
BirdData<-cbind(Wingcrd,Tarsus,Head,Wt)
BirdData

# accesses data via rows (left) and columns (right)
BirdData[3,] #gives all columns of the third row
BirdData[,4] #gives all rows of the fourth column
BirdData[1,1] #first row and first column value
BirdData[,2:3] #all rows for columns 2 and 3
BirdData[,-3] #all rows for all columns except the third
BirdData[,c(1,3,4)] #all rows for the first, third, and fourth column
BirdData[,c(-1,-3)] #all rows for all columns except the first and third

#use setwd() to set the working directory
setwd("/Users/nbrodnax/Research/Tools/R")
#getwd() tells you what the current working directory is

#export the data using write.table()
write.table(BirdData,"BirdData.csv",sep=",")
#import data using read.table()
data1<-read.table("BirdData.csv",header=TRUE) #stores the data in a dataframe
BirdData #matrix format
data1 #dataframe format
#determine if data is in a dataframe using is.data.frame()
#convert data to a dataframe using as.data.frame()
data2<-as.data.frame(BirdData)
data2

#call column names using a $
data2$Wingcrd #this only works with a dataframe
sum(data2$Wingcrd)
sum(na.omit(data2$Head))

#get the column names using colnames
colnames(data2)

library(irr)
data(diagnoses) #this irr package comes with a dataset
diagnoses
diagnoses$rater1
length(diagnoses$rater1) #the length of the column
summary(diagnoses$rater1) #the count of each level (diagnosis) in the variable
is.factor(diagnoses$rater1) #tells whether the variable is categorical
is.numeric(diagnoses$rater1) #tells whether the variable is numeric

#Recode variables: replace every "Other" with "Enjoys Statistics"
levels(diagnoses$rater1)[levels(diagnoses$rater1)=="5. Other"]<-"Enjoys Statistics" #when the level is equal to something, assign it to something else
diagnoses$rater1

mtcars #preexisting dataframe in R (the developers like cars)
is.factor(mtcars$vs) #ask R if vs is categorical (no)
mtcars$vs<-as.factor(mtcars$vs) #convert vs to a categorical variable
is.factor(mtcars$vs) #(yes)

#return cars with horsepower greater than 200
mtcars[mtcars$hp>=200,] #returns all rows where the expression is true for all columns

#use & to specify more than one condition
mtcars[mtcars$hp>=200 & mtcars$wt<=5,]

#use the vertical bar for the OR operator
mtcars[(mtcars$hp>=200 & mtcars$wt<=5) | mtcars$mpg>30,]

#check the correlation between two variables
cor(mtcars$mpg,mtcars$wt)

#check the correlation across a matrix but first make everything numerical
mtcars$vs <- as.numeric(mtcars$vs) #converts vs back to numeric
cor(mtcars) #this returns a big correlation matrix

#another way to create a matrix using matrix()
matA<-matrix(c(25,5,25,25),ncol=2,byrow=TRUE) #ncol tells it the number of columns
matB<-matrix(c(16,11,13,14),ncol=2,byrow=TRUE)

#give the matrix row and column names
rownames(matB)<- c("Male","Female")
colnames(matB)<- c("Smoker","Non-Smoker")
rownames(matA)<- c("IN Resident", "Non-IN Resident")
colnames(matA)<- c("Basketball","Other")

#perform a chi-sq test
chisq.test(matB)
chisq.test(matA)

#perform a t test
t.test(mtcars$mpg,mu=20,alternative="greater")
#the default alternative is a two-tailed test
#you can also do a t test with more than one sample

#plotting
plot(mtcars)
#eliminate discrete variables
plot(mtcars[,c(-2,-8:-10)])
#plot the relationship between two variables
plot(mtcars$wt,mtcars$mpg, xlab="Weight (tons)",ylab="Miles per Gallons", main="Vehicle MPG by Weight")

#set parameters within the plot function
plot(mtcars$wt,mtcars$mpg, xlab="Weight(tons)", ylab="Miles per Gallon", main="Vehicle MPG by Weight",col=ifesle(mtcars$cyl==4,"black",ifelse(mtcars$cyl==6,"hotpink","skyblue")),pch=16) #this didn't work

#use the identify function to interact with your plots
identify(mtcars$wt,mtcars$mpg)

#add a legend to your plot (see slides)
plot(mtcars$wt,mtcars$mpg,xlab="Weight (tons)",ylab="Miles per Gallon")

#add histogram
hist(mtcars$qsec,xlab="qsec")

#important packages for plots are Lattice and GGplot2 (there are books available on these)

#linear modeling using the lm() function
#first create an object called fit to store the linear model
fit.slr<-lm(mpg ~wt,mtcars) #no feedback is normal
summary(fit.slr) #this provides the results of the model

#use abline to add the fitted linear model to the scatterplot

#plot the residuals
plot(mtcars$wt,fit.slr$resid,ylab="Residuals")