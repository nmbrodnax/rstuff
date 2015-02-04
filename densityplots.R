#Adapted from http://onertipaday.blogspot.com/2007/09/plotting-two-or-more-overlapping.html

plot.multi.dens <- function(s)
{
  junk.x = NULL
  junk.y = NULL
  for(i in 1:length(s))
  {
    junk.x = c(junk.x, density(s[[i]])$x)
    junk.y = c(junk.y, density(s[[i]])$y)
  }
  xr <- range(junk.x)
  yr <- range(junk.y)
  plot(density(s[[1]]), xlim = xr, ylim = yr, main = "")
  for(i in 1:length(s))
  {
    lines(density(s[[i]]), xlim = xr, ylim = yr, col = i)
  }
}
#usage:
x = theta1.sim
y = theta2.sim
# the input of the following function MUST be a numeric list
plot.multi.dens(list(x,y))