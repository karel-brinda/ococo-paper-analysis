#!/usr/bin/env Rscript

library(optparse)

kIsRStudio <- Sys.getenv("RSTUDIO") == "1"

if (kIsRStudio) {
  src.file <- '../02_online_calling/Chlamydia_trachomatis.stats.tsv'
  genome.length <- 1046171
} else {
  parser <-
    OptionParser(usage = "%prog [options] timeline.tsv plot.pdf genome.length")
  arguments <- parse_args(parser, positional_arguments = 3)

  opt <- arguments$options

  src.file <- arguments$args[1]
  out.file <- arguments$args[2]
  genome.length <- as.numeric(arguments$args[3])

  kWidth <- 6
  kHeight <- 6

  pdf(out.file,
      width = kWidth,
      height = kHeight)
}

palette(c("#aa0000", "#000088", "gray50"))

a = read.table(file = src.file,
               header = T,
               na.strings = "?")

a$kaln = a$aln / 1000

y1 = 0
y2 = max(max(a$upd, na.rm = T),
                max(a$ed_dist, na.rm = T))

x1 = 0
x2 = min(max(a$kaln, na.rm = T))

CEX = 0.6

options(scipen = 1)

xrange_ = range(c(x1, x2))
yrange_ = range(c(y1, y2))

xticks = pretty(xrange_, n=10)
yticks = pretty(yrange_)

xrange=c(min(xticks), max(xticks))
yrange=c(min(yticks), max(yticks))

plot(
  c(),
  c(),
  xlim = xrange,
  ylim = yrange,
  xlab = NA,
  ylab = NA,
  xaxs = "i",
  yaxs = "i",
  axes = FALSE
)

grid(col = "lightgray",
     lty = "dotted",
     equilogs = TRUE)
par(new = TRUE)

legend(
  x = "right",
  legend = c(
    "Edit distance",
    "Cumulative number of updates",
    "Uncallable indels"
  ),
  bg = "white",
  col = c(1, 2, 3),
  lwd = c(1, 1, 1),
  lty = c(1, 2, 5),
  #pch=c(1,2,NA),
  cex = 0.8
)

par(mgp=c(0, 0.7, 0))
axis(1,
     las = 1,
     cex.axis = 0.9,
     xpd = TRUE)
axis(2,
     las = 1,
     cex.axis = 0.9,
     xpd = TRUE)



ratio=1000*100/genome.length
xx.limits=c(0, min(max(a$kaln, na.rm = T))*ratio  )
xx.ticks=pretty(xx.limits)

axis(
   3,
   las = 1,
   at=xx.ticks/ratio,
   col = "grey",
   cex.axis = 0.8,
   #lwd = 0,
   labels=paste0(xx.ticks,'x')
)

mtext("Coverage", side = 3, line = 1.8)
mtext("Number of reads (thousands)", side = 1, line = 2)


lines(spline(a$kaln, a$ed_dist), lt = 1, col = 1)
par(new = TRUE)
lines(spline(a$kaln, a$upd), lt = 2, col = 2)
par(new = TRUE)
lines(spline(a$kaln, a$dels+a$ins), lt = 5, col = 3, lw=1)


if (!kIsRStudio) {
  dev.off()
}
