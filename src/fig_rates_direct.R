
suppressPackageStartupMessages({
  library(dplyr)
  library(ggplot2)
  library(command)
})

cmd_assign(.data = "out/data.rds",
           col_line_1 = "#228B22",
           col_line_2 = "#7E1E9C",
           .out = "out/fig_rates_direct.pdf")

data <- readRDS(.data)

p <- ggplot(data, aes(x = time, y = deaths/popn, color = sex)) +
  facet_wrap(vars(age), nrow = 1) + #, scale = "free_y") +
  geom_line(linewidth = 0.2) +
  scale_color_manual(values = c(col_line_1, col_line_2)) +
  scale_y_log10() +
  ylab("") +
  xlab("")

pdf(file = .out,
    width = 6,
    height = 7)
plot(p)
dev.off()        


