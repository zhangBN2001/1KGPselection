
library("qqman")
library("ggplot2")

file<-"step4.all.sel.10.1.map.withlle"
args<-c(file,paste(file,".pdf",sep=""))
data <- read.table(args[1],header=TRUE)
data2 <- data[head(order(data$lle.ratio,decreasing=TRUE),2000),]
pdf(args[2],width = 15 , height = 4)
manhattan(data2, chr="Chr", bp="Position", p="lle.ratio",logp=FALSE, col=c("#4197d8", "#f8c120", "#413496", "#495226", "#d60b6f", "#e66519", "#d581b7", "#83d3ad", "#7c162c", "#26755d"),suggestiveline=FALSE,genomewideline=FALSE,ylab="-log10(adjusted p-value)")
dev.off()
