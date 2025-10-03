#set up environment and packages that will be called
library(DESeq2)
library(ggplot2)
library(ggrepel)
library(tidyverse)
library(dplyr)
library(tibble)
library(writexl)

#import file locally
setwd("C:\\Users\\drive\\folder\\")
count <- read.delim('C:\\Users\\projects\\folder\\path\\to\\file.csv', 
                    header = TRUE, sep = ',')
rownames(count) <- count$Gene

#do we filter out low values? What's the threshold we want here
#then filter out curto associated gene
commcount <- count %>%
  select(order(colnames(count))) %>%
  filter(!grepl("NALEJ", Gene)) %>%
  select(-Gene)

#graph data
#Volcano using ggplot2
commvolcano <- ggplot(dflabelcomm, aes(x = log2FoldChange, y = -log10(pvalue), col = Species)) + #call ggplot, the package to make the graph
  geom_point() +  #each of these "geom_..." functions dictates a visual aesthetic of the graph
  geom_hline(yintercept = -log10(0.05), linetype = "dashed") +
  geom_vline(xintercept = c(-0.5, 0.5), linetype = "dashed") +
  # geom_label_repel(
  #     data = dflabelcomm,
  #     aes(label = Genes),
  #     size = 3, 
  #     nudge_x = 0.1, 
  #     nudge_y = 0.1) +
  labs(title = "Regulation of Genes Expressed With and Without Curtobacterium")
print(commvolcano)