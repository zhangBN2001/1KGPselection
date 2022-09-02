library("qqman")
#library("ggplot2")


workdir <- ""   #### all results LLR files in this folder. 
dir <- list.files(workdir)

for ( i in 1:length(dir) ){
  file=paste(workdir,dir[i],sep="")
  if 
  args<-c(file,paste(file,".pdf",sep=""))
  data <- read.table(args[1],header=TRUE)
  data2 <- data[head(order(data$lle,decreasing=TRUE),2000),]
  pdf(args[2],width = 15 , height = 4)
  manhattan(data2, chr="Chr", bp="Position", p="lle",logp=FALSE, col=c("#4197d8", "#f8c120", "#413496", "#495226", "#d60b6f", "#e66519", "#d581b7", "#83d3ad", "#7c162c", "#26755d"),suggestiveline=FALSE,genomewideline=FALSE,ylab="-log10(adjusted p-value)")
  dev.off()
}
