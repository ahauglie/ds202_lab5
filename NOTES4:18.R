#Recreating the Top Dog plot 
  #show them as points with labels of each dog
  #type of dog using color
    #information is found in excel file in "category"
  #size of dog is in "size"
  #data score is in the second sheet as "datadog score"
  #popularity score (use either one, see which looks better)
  #intelligence is in first sheet 
  #each dog is a point, x axis is data score, y is popularity
  #breed of dog shown using text
  #size can be size of point
  #intelligence could be like a triangle or a square instead of a point
  

#Polishing Plots

#the default
library(tidyverse)
p1 <- mpg %>% filter(year == 2008) %>%
  ggplot(aes(x = cty, y = hwy, color = cyl)) +
  geom_point()
p1 + scale_color_continuous() #this is for a continuous variable (cyl can be anywhere from 4-8)
  #this is the default color scheme, same as just plotting p1
p1
  #see, same as above

#change the color scheme
p1 +scale_color_gradient() #this is the default, but there are more options for this function
?scale_color_gradient
#create a two color gradient, low to high, using hex codes for color
p1 +scale_color_gradient(low="#FF0000", high="#0000FF")
  #"#FF0000" hex code for red
  #It is a code for RGB, in the hex code F=15, so FF=15*16 +15=255. So "#FF0000" is (255, 0, 0) so highest red, no green no blue
  #"#0000FF" this is blue
p1 +scale_color_gradient(low="red", high="blue")

p1 +scale_color_gradient(low="#56B1F7", high="#132B43")

p1 +scale_color_gradient(trans="log10")


#gradient2: this is a 3 color gradient, low, mid, and high colors
p1+scale_color_gradient2()
?scale_color_gradient2 #default midpoint is 0
p1+scale_color_gradient2(midpoint=6) #so we see here that this is a diverging color scheme
p1 +scale_color_gradient2(midpoint=6, low="green", mid="blue", high="red")


#YOUR TURN: using diamonds data
library(classdata)
?diamonds
#plot the size (carat) versus the price of the diamonds, and colors the points also according to price
diamonds.plot <- ggplot(diamonds, aes(x=carat, y=price, color = price))+geom_point()
diamonds.plot +scale_color_gradient(low = "darkolivegreen1", high="darkolivegreen")
diamonds.plot +scale_color_gradient2(low = "darkolivegreen1", mid="darkolivegreen2", high="darkgreen", midpoint=10000)

#You can look up the hex codes for different brands, like ISU colors below
ggplot(diamonds, aes(x=carat, y=price, color=price))+geom_point()+scale_color_gradient(low="#C8102E", high="#F1BE48")


#Discrete colors 
p2 <- mpg %>% filter(year == 2008) %>%
  ggplot(aes(x = cty, y = hwy, color = factor(cyl))) +
  geom_point()
p2 + scale_color_discrete() #now cyl is only 4,5,6,8 which is a factor
p2 +scale_color_hue()
?scale_color_hue #evenly spaced colors for discrete data, arguements are h, c, l
p2 +scale_color_hue(c=200) #h: hue, c:chroma/saturation (default=100), l:lightness (default=65)
p2 +scale_color_hue(c=200, l=30) #l=smaller is darker, higher is lighter

?scale_color_manual
colorsexample <- c("4" = "blue", "5" = "yellow", "6"="darkgreen", "8"='red')
p2 +scale_color_manual(values = colorsexample)


#Color Brewer, great for drawing maps
  #qualitative color scheme 
library(RColorBrewer)
display.brewer.all()
p2 +scale_color_hue()
p2 + scale_color_brewer(palette = "Set2")


#YOUR TURN
#
diamondsplot2 <- ggplot(diamonds, aes(x=carat, y=price, color=clarity))+geom_point()
diamondsplot2+scale_color_brewer(palette="RdYlGn")

diamondsplot2+scale_color_brewer(palette="Blues")+theme_dark()
  #we want to show clearer diamonds using the lighter ones though so let's flip
diamondsplot2+scale_color_brewer(palette="Blues", direction=-1)+theme_dark() #default direction is 1 so -1 will flip it
#we can see that if you fix the carat weight, diamonds that shine brighter (clearer) are more expensive
#Don't use a qualitative color scheme, it doesn't inform people much


#Brewer color schemes are only for discrete colors
#color distiller is a continuous version of color brewer
states <- map_data('state')
states %>% ggplot(aes(x = long, y = lat)) + 
  geom_polygon(aes(group = group, fill=lat)) + 
  scale_fill_distiller(palette='Blues') #since we use fill and not outline we use scale_fill


#THEMES for ggplot: a set of options specifying how a plot should look, (dark/light background, gridlines, etc.)
#there are some predefined themes, but you can do it yourself too
#theme_set will apply a theme to all sets

p <- mpg %>% ggplot(aes(x=displ, y=cty, color=factor(class)))+geom_point()
p #this is the default theme
p + theme_gray()
p + theme_bw() #good for printouts
p + theme_light() #removes some areas
p + theme_dark()

install.packages("ggthemes")
library(ggthemes)

p + theme_excel()


#ELEMENTS
mpg %>% ggplot(aes(x = manufacturer)) + geom_bar() +
  theme(axis.text.x = element_text(angle=45, vjust=1, hjust=1))


#STAT 480
