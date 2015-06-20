#Code for ggplot2 talk 

#Libraries
library(ggplot2)

#WHAT IS A STATISTICAL GRAPH
# Okay with the preliminaries aside let's dive into the hear of the question
# What do we mean by a statistical graph?
# Well, in some part I want to dodge the question. You could say that the whole reason
# Leland Wilinson developed the grammar of graphics was to answer the question
# As a first approximation let's say that a statistical graph starts with a data set,
# some map from the data to something visual (aesthetic value), and some sort of guide
# or scale to let the viewer know how to interpret the visual information.


#Example 1 Cartesian grap of y=x^2 the data is a set of ordered pairs
# for all the ordered pairs we map the first coordinate to a horizontal displacement
# and the second to a vertical

#Example 2 Minard's Napoleon Map
#We will revisit this in the end but Edward Tufte said this graph mapped six different 
#dimensions on on graph


#QPLOT
#The easiest way to get started with ggplot2 stuff with the quick plotting function
#qplot()
#I'll be plotting some graphs from a dataset called diamonds in the ggplot2
#package
head(diamonds)
#The data set has the "Four Cs" of diamond quality, price, and some measurements:
# three spacial measurements, and two ratios. It's nice because we have alot 
# of things we can things we can plot against each other. Also, there are over
# 50,000 entries so we can look at some ways to handle overplotting

plot(diamonds$carat,diamonds$price)
qplot(carat,price,data=diamonds)

#Let me point put a couple of nice features about the qplot defaults.
#The margins are smaller and the axis labels are smaller. So we get more room to display
# the data.
# To be fair, default plotting is trying to leave space for a possible title. qplot()
# will redraw.
qplot(carat,price,data=diamonds)+labs(title="Title")

#The axis labels for qplot() are a bit nice
# If we had called 
qplot(diamonds$carat,diamonds$price)

#We could have more closely aped plot(), but it's nice to be able to specify the
# data within the function call

#The qplot() default shape is a solid dot. The open dot of plot() can help distinguish
# nearby plots. I like the dots. If there's overplotting I want to be explicit
# about how I'm dealing with it.

#Of course the most noticable thing is that the background is grey with white gridlines
# This follows suggestions Tufte, Carr, Brewer, and others. The gridlines can help but
# are easy to tune out. Also, the grey gives a continuous field of color to promote
# the idea that the graph is a single visual object.


#Note that is you give plot() one numeric vector it plots it against row number
# qplot() will default to a histogram
plot(diamonds$carat)
qplot(diamonds$carat)


qplot(carat,price,data=diamonds,shape=cut,color=color)

qplot(carat,price,data=diamonds,geom=c("point","smooth"))
qplot(carat,price,data=diamonds)+geom_smooth()

#MORE GENERAL PLOTS


#All together, the layered grammar defines a plot as the combination of:
# A default dataset and set of mappings from variables to aesthetics.
# One or more layers, each composed of a geometric object, a statistical
#transformation, and a position adjustment, and optionally, a dataset and
#aesthetic mappings.
# One scale for each aesthetic mapping.
# A coordinate system.
# The faceting specification.

#With this in mind make a ggplot object

p <- ggplot(diamonds, aes(x=carat)

#We could have done the same with
p <- ggplot(diamonds, aes(carat))

#We now have a default dataset, diamonds, and some default aesthetic mappings
#We can override them if we chose

#We can add a layer to p with +

p + 
  layer(geom = "bar",geom_params = list(fill = "steelblue"),
        stat = "bin",stat_params = list(binwidth = 2))

#We don't need to specify everything since ggplot2 makes some sensible (knock wood) 
# defaults

p + 
     geom_bar(geom_params = list(fill = "steelblue"),stat_params = list(binwidth = 2))

#Every geom has a default stat transformation and every stat has a default geom

#SCALES
#I've mentioned the aesthetic mapping but kind of slid over the issue what what
# gets mapped to what

p <- ggplot(diamonds, aes(carat, price, colour = cut))+geom_point()

#We can decide we want to mark to plot the y axis on a logarithmic scale
p+scale_y_log10()

#Or use a log-log scale
p+scale_x_log10()+scale_y_log10()

#In lots of plotting packages there are commands specifically to tweak the axes
# In ggplot2 it should all be handled by the scales

#In fact all the aesthetics are handled by sclaes
#The cut is a discrete value by default ggplot2 scales 5 values from as spread 
# apart on a color wheel as possible
p+scale_color_discrete(h=c(0,180))
p+scale_color_discrete(h=c(0,30))

#The discrete colors use a hue, chroma, luminesence specification
p+scale_color_discrete(h=c(0,180),c=100,l=20)
p+scale_color_discrete(h=c(0,180),c=100,l=100)

#There are many built in scales
#Cynthia Brewer from Penn State has several suggest
p+scale_color_brewer(type="div",palette = 4)

#All the color scales so far have been divergent this is a good fit for dicrete values such as cut
# If we were mapping a continuous values such as depth we want 

q<- ggplot(diamonds, aes(carat, price, colour = depth))+geom_point()
#ggplot recoginzes that depth is continuous and creates a smooth transition guid
q

#We can alter the scale to interpolate between other 
q+scale_color_continuous(low="black",high="pink"))

#For more fine tuned control use scale_colour_gradientn()
q+scale_colour_gradientn(colours = c("red","green","steel blue"))
q+scale_color_gradientn(colours=terrain.colors(10))
#For some data sets there are conventional color choices. If you ignore them,
# you are going to confuse them so make sure you have a good reason
# If this last plot were some sort of geographic map, you would definitly want the green to be lowlands
# and the brown to be mountains.

#SC:OVERPLOTTING
#We've noticed some overplotting issues
td <- ggplot(diamonds, aes(table, depth)) +xlim(50, 70) + ylim(50, 70)

#Lots of overplotting
td+geom_point()

#Adding jitter
td+geom_jitter(position=position_jitter(width = .1))

#Adding too much jitter
td+geom_jitter(position=position_jitter(width = .5))

#I like adding transparency
td + geom_jitter(position = position_jitter(width = .1), alpha=.1 )


#FACETING
#Many times you will want to split your data in some natural way and display several 
# graphs.
qplot(carat,price,data=diamonds,color=color)
qplot(carat,price,data=diamonds,color=color) + facet_grid(color~.)
qplot(carat,price,data=diamonds,color=color) + facet_grid(.~cut)
qplot(carat,price,data=diamonds,color=color) + facet_grid(color~.cut)

#COORDINATE SYSTEMS
gplot(diamonds, aes(x = factor(1), fill = cut)) +  geom_bar(width = 1)
ggplot(diamonds, aes(x = factor(1), fill = cut)) +  geom_bar(width = 1)+coord_polar()
ggplot(diamonds, aes(x = factor(1), fill = cut)) +  geom_bar(width = 1)+coord_polar(theta="y")


#THEMES 
#At some point you understand your data and you have an decent representation of it
#There's still a good chance that you will want to tweak some things. In ggplot2 it's
#possible to delay this step until the end.

hgram <- qplot(cut, data = diamonds, binwidth = 1)
hgram
theme_set(theme_bw())
#When we replot it will be with the new theme
hgram

hgram+labs(title = "This is a histogram")+ theme(axis.text.x=element_text(color="green"))
hgram+labs(title = "This is a histogram")+ theme(axis.title.x=element_text(color="green"))
hgram+labs(title = "This is a histogram")+ theme(plot.title=element_text(color="green"))


#Removing elements
hgram+theme(axis.title.x = element_blank(), 
            axis.title.y = element_blank())
    +theme(panel.background = element_blank())

library(ggthemes)

hgram+theme_economist()

#A theme by Ethan Schoonover http://ethanschoonover.com/solarized
#meant to evoke a reading on a summer day
hgram+theme_solarized()

#Fake Tableau
p <- ggplot(diamonds, aes(carat, price, colour = cut))+geom_point()
p+scale_color_tableau()


#REVISTING MINARD
#Just looking at the top part
troops <- read.table("troops.txt", header=TRUE)
cities <- read.table("cities.txt", header=TRUE)

xlim <- scale_x_continuous(limits = c(24, 39))

ggplot(cities, aes(x = long, y = lat)) + 
  geom_path(
    aes(size = survivors, colour = direction, group = group), 
    data=troops
  ) + 
  geom_point() + 
  geom_text(aes(label = city), hjust=0, vjust=1, size=4) + 
  #scale_size(to = c(1, 10)) +
  scale_size(range = c(1, 10)) +
  scale_colour_manual(values = c("grey","red"))  +
  xlim