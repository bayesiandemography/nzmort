
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
  group_by(sex, age) |>
  arrange(time) |>
  mutate(pc_change = 100 * (.fitted / lag(.fitted) - 1)) |>
  mutate(draws_ci(pc_change))

p <- ggplot(data, aes(x = time)) +
  facet_wrap(vars(age)) +
  geom_hline(yintercept = 0,
             linewidth = 0.2) +
  ## geom_ribbon(aes(ymax = pc_change.upper,
  ##                 ymin = pc_change.lower,
  ##                 fill = sex)) +
  geom_line(aes(y = pc_change.mid,
                color = sex),
            linewidth = 0.5) +
  scale_fill_manual(values = c(col_fill_1, col_fill_2)) +
  scale_color_manual(values = c(col_line_1, col_line_2)) +
  ylab("") +
  xlab("")


