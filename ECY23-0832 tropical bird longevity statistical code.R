library(ggplot2)
library(forcats)
library(dplyr)

#read in data
long2<-read.delim("Pollock et al. 2023 longevity dataset.txt", header=TRUE)

#format variables
long2$species<-as.factor(long2$species)
long2$family<-as.factor(long2$family)
long2$long_yr<-as.numeric(long2$long_yr)
long2$times_captured<-as.numeric(long2$times_captured)


##Fig 2A: longevity by species, highest to lowest longevity
panama<-long[long$location=='Panama',]
fig2a<-ggplot(panama, aes(x = reorder(sci_name, desc(longevity)), y=longevity))+geom_col()+
  theme_classic()+
  scale_y_continuous(breaks=c(0,5,10,15,20), limits=c(0,20))+
  xlab("")+
  annotate("text", label= "FIGURE 2A", x =4, y = 20, size=6)+
  ylab("Longevity (years)")+
  theme(axis.text.x=element_text(angle=90, vjust =0.5, face = "italic"))


#Fig 2B: longevity by family
fig2b<-ggplot(panama, aes(x=reorder(Family, desc(longevity)), y=longevity))+geom_boxplot(aes(fill=pass, color=pass))+
  geom_point(size=2)+
  theme_classic()+
  xlab("Taxonomic family")+
  ylab("Longevity (years)")+
  annotate("text", label= "FIGURE 2B", x =1.7, y = 20, size=6)+
  scale_y_continuous(limits=c(0,20), breaks=seq(0,20,4))+
  theme(axis.text.x=element_text(angle=90, vjust=0.5),
        legend.position = c(0.85, 0.85),
        legend.title = element_blank())

library(gridExtra)
grid.arrange(fig2a,fig2b, nrow=2)