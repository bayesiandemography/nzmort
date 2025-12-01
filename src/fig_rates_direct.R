
suppressPackageStartupMessages({
  library(dplyr)
  library(ggplot2)
  library(command)
})

cmd_assign(.data = "out/data.rds",
           col_female = "darkorange",
           col_male = "darkblue",
           .out = "out/fig_rates_direct.pdf")

data <- readRDS(.data)

p <- ggplot(data, aes(x = time, y = deaths/popn, color = sex)) +
  facet_wrap(vars(age)) +
  geom_line(linewidth = 0.2) +
  scale_color_manual(values = c(col_female, col_male)) +
  scale_y_log10(labels = function(x) format(x, scientific = FALSE)) +
  ylab("") +
  xlab("") +
  theme(legend.title = element_blank())

png(file = .out,
    width = 6,
    height = 5,
    unit = "in",
    res = 600)
plot(p)
dev.off()        


