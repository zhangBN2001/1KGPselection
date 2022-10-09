library(ggplot2)
library(reshape2)
library(ggsignif)
library(ggpubr)
library(patchwork)
library(dplyr)

df_A = read.csv("1A.list",
               sep = "\t" ,header = F
)
df_D = read.csv("1D.list",
                sep = "\t" ,header = F
)
df_E = read.csv("1E.list",
                sep = "\t" ,header = F
)
df_I = read.csv("1I.list",
                sep = "\t" ,header = F
)
df_U = read.csv("1U.list",
                sep = "\t" ,header = F
)
df_c = read.csv("c.list",
                sep = "\t" ,header = F
)
df_d = read.csv("d.list",
                sep = "\t" ,header = F
)
df_e = read.csv("e.list",
                sep = "\t" ,header = F
)
df_i = read.csv("i.list",
                sep = "\t" ,header = F
)
df_u = read.csv("u.list",
                sep = "\t" ,header = F
)
df_A$V2 = factor(df_A$V2, levels=c('SNV','ID','SV'))
df_D$V2 = factor(df_D$V2, levels=c('SNV','ID','SV'))
df_E$V2 = factor(df_E$V2, levels=c('SNV','ID','SV'))
df_I$V2 = factor(df_I$V2, levels=c('SNV','ID','SV'))
df_U$V2 = factor(df_U$V2, levels=c('SNV','ID','SV'))
df_c$V2 = factor(df_c$V2, levels=c('SNV','ID','SV'))
df_d$V2 = factor(df_d$V2, levels=c('SNV','ID','SV'))
df_e$V2 = factor(df_e$V2, levels=c('SNV','ID','SV'))
df_i$V2 = factor(df_i$V2, levels=c('SNV','ID','SV'))
df_u$V2 = factor(df_u$V2, levels=c('SNV','ID','SV'))

df_A$V1 = factor(df_A$V1, levels=c('0_0.1','0.1_0.5','0.5_1','1_2'))
df_D$V1 = factor(df_D$V1, levels=c('0_0.1','0.1_0.5','0.5_1','1_2'))
df_E$V1 = factor(df_E$V1, levels=c('0_0.1','0.1_0.5','0.5_1','1_2'))
df_I$V1 = factor(df_I$V1, levels=c('0_0.1','0.1_0.5','0.5_1','1_2'))
df_U$V1 = factor(df_U$V1, levels=c('0_0.1','0.1_0.5','0.5_1','1_2'))
df_c$V1 = factor(df_c$V1, levels=c('0_0.1','0.1_0.5','0.5_1','1_2'))
df_d$V1 = factor(df_d$V1, levels=c('0_0.1','0.1_0.5','0.5_1','1_2'))
df_e$V1 = factor(df_e$V1, levels=c('0_0.1','0.1_0.5','0.5_1','1_2'))
df_i$V1 = factor(df_i$V1, levels=c('0_0.1','0.1_0.5','0.5_1','1_2'))
df_u$V1 = factor(df_u$V1, levels=c('0_0.1','0.1_0.5','0.5_1','1_2'))

pA=ggplot(df_A, aes(x=V1, y=V3,fill=V2,group=interaction(V2,V1))) + 
  scale_fill_manual(values=c("SNV" = "red", "ID" = "blue", "SV" = "green")) +
  geom_boxplot()+ylim(10,150)
pD=ggplot(df_D, aes(x=V1, y=V3,fill=V2,group=interaction(V2,V1))) + 
  scale_fill_manual(values=c("SNV" = "red", "ID" = "blue", "SV" = "green")) +
  geom_boxplot()+ylim(10,150)
pE=ggplot(df_E, aes(x=V1, y=V3,fill=V2,group=interaction(V2,V1))) + 
  scale_fill_manual(values=c("SNV" = "red", "ID" = "blue", "SV" = "green")) +
  geom_boxplot()+ylim(10,150)
pI=ggplot(df_I, aes(x=V1, y=V3,fill=V2,group=interaction(V2,V1))) + 
  scale_fill_manual(values=c("SNV" = "red", "ID" = "blue", "SV" = "green")) +
  geom_boxplot()+ylim(10,150)
pU=ggplot(df_U, aes(x=V1, y=V3,fill=V2,group=interaction(V2,V1))) + 
  scale_fill_manual(values=c("SNV" = "red", "ID" = "blue", "SV" = "green")) +
  geom_boxplot()+ylim(10,150)
pc=ggplot(df_c, aes(x=V1, y=V3,fill=V2,group=interaction(V2,V1))) + 
  scale_fill_manual(values=c("SNV" = "red", "ID" = "blue", "SV" = "green")) +
  geom_boxplot()+ylim(10,150)
pd=ggplot(df_d, aes(x=V1, y=V3,fill=V2,group=interaction(V2,V1))) + 
  scale_fill_manual(values=c("SNV" = "red", "ID" = "blue", "SV" = "green")) +
  geom_boxplot()+ylim(10,150)
pe=ggplot(df_e, aes(x=V1, y=V3,fill=V2,group=interaction(V2,V1))) + 
  scale_fill_manual(values=c("SNV" = "red", "ID" = "blue", "SV" = "green")) +
  geom_boxplot()+ylim(10,150)
pi=ggplot(df_i, aes(x=V1, y=V3,fill=V2,group=interaction(V2,V1))) + 
  scale_fill_manual(values=c("SNV" = "red", "ID" = "blue", "SV" = "green")) +
  geom_boxplot()+ylim(10,150)
pu=ggplot(df_u, aes(x=V1, y=V3,fill=V2,group=interaction(V2,V1))) + 
  scale_fill_manual(values=c("SNV" = "red", "ID" = "blue", "SV" = "green")) +
  geom_boxplot()+ylim(10,150)

ggplot()+
  theme_void() -> p1
(p1+pA+pD+pE+pI+pU+pc+pd+pe+pi+pu)
