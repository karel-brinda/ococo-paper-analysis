#!/usr/bin/env Rscript

library(data.table)
library(optparse)

isRStudio <- Sys.getenv("RSTUDIO") == "1"
set.seed(42)

if (isRStudio) {
  src.file = "../03_time_comparison/Chlamydia_trachomatis.summary.tsv"
} else {
  parser <- OptionParser(usage = "%prog summary.tsv plot.pdf")
  arguments <- parse_args(parser, positional_arguments = 2)

  opt <- arguments$options

  src.file <- arguments$args[1]
  out.file <- arguments$args[2]

  pdf(out.file,
      width = 5,
      height = 5)
}

df <- read.delim(src.file, header = F, row.names = 1)

row.names(df) <- row.names(df)

df$varscan = df$V2
df$ococo = df$V2
df$ord = 0 * df$V2


df <- subset(df, select = -c(V2))

# for sorting
df[rownames(df) %like% "sort", ]$ord = 10
df[rownames(df) %like% "pileup", ]$ord = 20
df[rownames(df) %like% "VarScan", ]$ord = 30
df[rownames(df) %like% "coco", ]$ord = 00


df[rownames(df) %like% "coco", ]$varscan = 0

df[rownames(df) %like% "pileup", ]$ococo = 0
df[rownames(df) %like% "SAMtools", ]$ococo = 0
df[rownames(df) %like% "VarScan", ]$ococo = 0

df[df$ococo == 0 & df$varscan == 0,] = NA
df <- df[order(df$ord),]
df <- na.omit(df)

dfs = df
df = subset(df, select = -c(ord))



ymin = 0
ymax = max(pretty(round(1.2 * max(
  sum(df$ococo), sum(df$varscan)
))))


tab = t(t(df))
xx = barplot(
  tab,
  ylim = c(ymin, ymax),
  names.arg = c("VarScan pipeline", "Ococo pipeline")
)
legend(
  "topright",
  legend = rownames(tab),
  fill = gray.colors(length(df$ococo)),
  cex = 0.8
)
text(
  x = xx,
  y = colSums(tab),
  label = colSums(tab),
  pos = 3,
  cex = 0.7,
  offset = 0.15,
  col = "black"
)


if (!isRStudio) {
  dev.off()
}
