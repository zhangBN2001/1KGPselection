library(ggplot2)
library(ggridges)
theme_set(theme_minimal())
list_A<-read.table("1lg2.list.csv",header = F,sep = ",")
list_A<-data.frame(p.value=list_A[,"V7"],class=list_A[,"V5"])
# Change the density area fill colors by groups
plo<-ggplot(
  list_A, 
  aes(x = `p.value`, y = `class`,fill =stat(x))
)

plo<-plo+geom_density_ridges_gradient(scale = 1, size = 0.3, rel_min_height = 0.00)+scale_fill_viridis_c(option = "C")
plo+scale_x_continuous(limits = c(-20,200))
