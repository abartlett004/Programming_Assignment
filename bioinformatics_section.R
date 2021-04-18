################################################################################
# Alex Bartlett
# March 13, 2021
#
# use a rolling average of log2ratios to calculate copy number of various genomic
# locations
################################################################################

library(tidyverse)
library(zoo)

################################################################################
# determine which value to use for width of the window or the rolling average
################################################################################

# load data
log2ratios <- read.table('log2Ratio_values.txt', header = T)
log2ratios$position <- as.numeric(log2ratios$position)

# for calculating approximate length in bases of window widths
avg_point2point_dist <- mean(diff(log2ratios$position))

# check a variety of window sizes
poss_windows <- c(5, 10, 15, 20, 30, 40, 50)
for (window in poss_windows){
  
  # to dampen noise, calculate rolling average of log2ratios
  LR_smooth <- rollmean(log2ratios$LR, window, fill = c('extend', 'extend', 'extend'))
  
  # calculate and visualize copy number (rounder to nearest integer)
  log2ratios$CN <- round(2 * (2 ^ LR_smooth))
  CN_vs_pos <- ggplot(log2ratios, aes(x = position/1e6, y = CN)) + geom_point(shape = 'o')
  ggsave(paste0('CN_vs_pos_window_', round(window * avg_point2point_dist/1e6, 2), 'MB.png'))
}


################################################################################
# return copy number for point or segment in genome 
################################################################################


# calculate rolling average of log2ratios using chosen window width
LR_smooth <- rollmean(log2ratios$LR, 30, fill = c('extend', 'extend', 'extend'))

# calculate and visualize copy number (rounder to nearest integer)
log2ratios$CN <- round(2 * (2 ^ LR_smooth))

write.table(log2ratios, 'copyNumber_values.txt', sep = '\t', row.names = F, quote = F)


# return copy number for segment with start and end coordinates
CN_segment <- function(start, end){
  data_start <- max(log2ratios$position[log2ratios$position <= start])
  data_end <- min(log2ratios$position[log2ratios$position >= end])
  
  CN <- round(mean(log2ratios$CN[log2ratios$position >= data_start & log2ratios$position <= data_end]))
  return(CN)
  
}

# return copy number for point
CN_point <- function(point){
  return(CN_segment(point, point))
}

# output copy numbers for requested genes
print(paste('PDPN:', CN_segment(13583831, 13617957)))
print(paste('MEAF6:', CN_segment(37492575, 37514763)))
print(paste('MIER1:', CN_segment(66924895, 66988619)))
print(paste('ADGRL2:', CN_segment(13583831, 13617957)))
print(paste('FCRL5:', CN_segment(157513377, 157552515)))
print(paste('PBX1:', CN_segment(164559635, 164851831)))
print(paste('USH2A:', CN_segment(215622891, 216423448)))
