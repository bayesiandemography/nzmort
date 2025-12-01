
suppressPackageStartupMessages({
  library(dplyr)
  library(rvec)
  library(ggplot2)
  library(command)
})

cmd_assign(.aug = "out/aug.rds",
           col_fill_1 = "#A6D854",
           col_line_1 = "#228B22",
           col_fill_2 = "#CC79A7",
           col_line_2 = "#7E1E9C",
           col_point = "red",
           .out = "out/fig_rates_all.pdf")

aug <- readRDS(.aug)

data <- aug |>
  mutate(draws_ci(.fitted))

p <- ggplot(data, aes(x = time)) +
  facet_wrap(vars(age)) +
  geom_line(aes(y = .fitted.mid,
                color = sex),
            linewidth = 0.2) +
  scale_color_manual(values = c(col_line_1, col_line_2)) +
  scale_y_log10(labels = function(x) format(x, scientific = FALSE)) +
  ylab("") +
  xlab("")

pdf(file = .out,
    width = 6,
    height = 7)
plot(p)
dev.off()        


