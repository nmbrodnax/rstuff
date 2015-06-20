#ggplot workshop
#install.packages("ggplot2")
install.packages("ggthemes")
library(ggplot2)
library(ggthemes)

#get code from the WIM website

#uses the diamond dataset included with the package
#qplot is the most basic plot, but it takes up more space than the base plot
qplot(carat,price,data=diamonds)
#has gray background with white guidelines (Tufte, Brewer, et al design)
#it uses cleaner titles rather than diamonds$carat and diamonds$price
#it also has a different default shape of solid circle rather than hollow

#the default for qplot with a single parameter is a histogram
qplot(carat,data=diamonds)

#you can incorporate other features of the data and it will include legends
qplot(carat,price,data=diamonds,shape=cut,color=color)

#points might be hard to understand, so we can use a smoother
qplot(carat,price,data=diamonds,geom=c("smooth"))
#points can also be combined with smoothing
qplot(carat,price,data=diamonds,geom=c("point","smooth"))
#qplot(carat,price,data=diamonds) + geom_smooth() does the same thing

#All objects include data plus the following:
#aesthetic mappings, geometrical properties, scales, coordinate system, faceting system

p <- ggplot(data=diamonds,aes(x=carat)) #where aes is an aesthetic mapping
p + layer(geom = "bar",geom_params=list(fill="steelblue"),stat="bin",stat_params=list(binwidth=2))
#we don't always need to add a layer; all geom and stat params have defaults
#geom_bar is for a histogram

#Scales control how your aesthetic mapping works with the data
p <- ggplot(diamonds,aes(carat,price,colour=cut))+geom_point()
p
p + scale_x_log_10() + scale_y_log10() #to change the scales of the axes

#Working with color - uses hue (color), chroma (purity), and luminance (brightness)
p + scale_color_discrete(h=c(0,180))
p + scale_color_discrete(h=c(0,30))
#Dropping the degrees from 360 reduces the range of the color scales
p + scale_color_discrete(h=c(0,180),c=100,l=100)
#Cynthia Brewer's palette is scale_color_brewer; she has several palettes intended to reflect
#whether items are related (sequential) or not
p + scale_color_brewer(type="div",palette=4)

#Can also make the color continuous
q <- ggplot(diamonds,aes(carat,price,colour=depth))+geom_point() #now color = depth
q
#you can define the gradients for the color scale
q+scale_color_gradientn(colours = c("red","green","blue"))
#this doesn't make sense since almost all diamonds are green

#We have a lot of overplotting, where we can't see what's what...
td <- ggplot(diamonds, aes(table,depth)) + xlim(50,70) + ylim(50,70)
td

#Four ways to deal with overplotting

#1 - Adding jitter (wiggle the points)
td + geom_jitter(position=position_jitter(width=0.5))
#Putting too much jitter can destroy the information from the data

#2 Adding alpha (transparency)

#3 Binning creates a heatmap
td + stat_bin2d() #binning into two-dimensional squares
#this is the same as td + geom_bin2d
td + stat_binhex() #binning into hexagons

#4 Faceting - breaking the data apart
qplot(carat,price,data=diamonds,color=color)
qplot(carat,price,data=diamonds,color=color) + facet_grid(color~.) #by color
qplot(carat,price,data=diamonds,color=color) + facet_grid(color~cut) #by color and cut

#Coordinate systems
ggplot(diamonds,aes(x=factor(1),fill = cut)) + geom_bar(width = 1)
#Now add polar coordinates
ggplot(diamonds,aes(x=factor(1),fill = cut))+ geom_bar(width=1) + coord_polar(theta="y")

#Themes
hgram <- qplot(cut,data=diamonds,binwidth=1)
hgram
#You can use themes to change the color on the axis as well as other elements
#use the theme_set() function to set the theme for all plots in the script
#Some examples of themes: theme_economist, theme_solarized, theme_bw