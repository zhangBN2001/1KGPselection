library("ggplot2")
a <- read.table("pcatmp.eigenvec.sort.group",header=TRUE)

a$ethnic <- paste(a$ancestry,a$ethnic,SEP="")

pdf("pcatmp.eigenvec.sort.group.pdf",10,7)
sd_1 <- sd(a$pc1)
sd_2 <- sd(a$pc2)
sd_3 <- sd(a$pc3)
total_sd <- sd_1 + sd_2 + sd_3
sd_1_p <- sd_1 * 100 / total_sd
sd_2_p <- sd_2 * 100 / total_sd

ggplot(a,aes(x=pc1,y=pc2))+ geom_point(aes(shape = factor(ancestry),color=ethnic))+ theme_bw() +theme(panel.border=element_blank(),panel.grid.major=element_blank(),panel.grid.minor=element_blank(),axis.line= element_line(colour = "black")) +
xlab(paste("PC1", " ")) + ylab(paste("PC2", " "))

dev.off()
