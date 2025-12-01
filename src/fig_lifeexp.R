
suppressPackageStartupMessages({
  library(dplyr)
  library(rvec)
  library(ggplot2)
  library(command)
})

cmd_assign(.lifeexp = "out/lifeexp.rds",
           col_fill_1 = "#A6D854",
           col_line_1 = "#228B22",
           col_fill_2 = "#CC79A7",
           col_line_2 = "#7E1E9C",
           col_point = "red",
           .out = "out/fig_lifeexp.pdf")

lifeexp <- readRDS(.lifeexp)

data <- lifeexp |>
  mutate(draws_ci(ex))

p <- ggplot(data, aes(x = time)) +
  facet_wrap(vars(at), ncol = 1, scale = "free_y") +
  geom_ribbon(aes(ymax = ex.upper,
                  ymin = ex.lower,
                  fill = sex)) +
  geom_line(aes(y = ex.mid,
                color = sex),
            linewidth = 0.5) +
  scale_fill_manual(values = c(col_fill_1, col_fill_2)) +
  scale_color_manual(values = c(col_line_1, col_line_2)) +
  ylab("") +
  xlab("")


