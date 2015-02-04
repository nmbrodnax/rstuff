# K300 Exam 2 Practice

#1a
conn = c(0,2,3,4,5)
pconn = c(0.3,0.25,0.15,0.2,0.1)

plot(conn, pconn, type="p", xlab="Internet Connections", ylab="Probability")
for(i in 1:5) {
  segments(conn[i],pconn[i], conn[i], 0, col="black")
}

#3a
mean=3000; sd=500
lb=4000; ub=5000

x <- seq(-4,4,length=100)*sd + mean
hx <- dnorm(x,mean,sd)

plot(x, hx, type="n", yaxt='n', ann=FALSE)

i <- x >= lb & x <= ub
lines(x, hx)
polygon(c(lb,x[i],ub), c(0,hx[i],0), col="gray") 

#3b
mean=3000; sd=500
lb=2000; ub=4000

x <- seq(-4,4,length=100)*sd + mean
hx <- dnorm(x,mean,sd)

plot(x, hx, type="n", yaxt='n', ann=FALSE)

i <- x >= lb & x <= ub
lines(x, hx)
polygon(c(lb,x[i],ub), c(0,hx[i],0), col="gray") 

#3c
mean=3000; sd=500
lb=3250; ub=5000

x <- seq(-4,4,length=100)*sd + mean
hx <- dnorm(x,mean,sd)

plot(x, hx, type="n", yaxt='n', ann=FALSE)

i <- x >= lb & x <= ub
lines(x, hx)
polygon(c(lb,x[i],ub), c(0,hx[i],0), col="gray") 

# K300 Exam 2 Solutions

#3a
mean=43; sd=1
lb=3; ub=41.9
d=c(41.9,43)

x <- seq(-3,3,length=100)*sd + mean
hx <- dnorm(x,mean,sd)

plot(x, hx, type="n", yaxt='n', ann=FALSE, axes=FALSE)

i <- x >= lb & x <= ub
lines(x, hx)
polygon(c(lb,x[i],ub), c(0,hx[i],0), col="gray") 
abline(v=mean)
abline(h=0)
axis(side=1, at=d, tick=FALSE, cex.axis=0.7)


#3b
mean=43; sd=1.8
lb=39; ub=44.5
d=c(39,43,44.5)

x <- seq(-3,3,length=100)*sd + mean
hx <- dnorm(x,mean,sd)

plot(x, hx, type="n", yaxt='n', ann=FALSE, axes=FALSE)

i <- x >= lb & x <= ub
lines(x, hx)
polygon(c(lb,x[i],ub), c(0,hx[i],0), col="gray") 
abline(v=mean)
abline(h=0)
axis(side=1, at=d, tick=FALSE, cex.axis=0.7)
