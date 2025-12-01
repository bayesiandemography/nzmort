
suppressPackageStartupMessages({
  library(readr)
  library(dplyr)
  library(tidyr)
  library(poputils)
  library(command)
})

cmd_assign(.deaths = "data/VSD349204_20251130_103448_2.csv.gz",
           .out = "out/deaths.rds")

age_labels <- age_labels(type = "lt", max = 100)
col_names <- c("time",
               paste("Male", age_labels, sep = "."),
               paste("Female", age_labels, sep = "."))
col_types <- paste(rep(c("c", "i"), times = c(1, 2 * length(age_labels))),
                   collapse = "")

deaths <- read_csv(.deaths,
                   skip = 4, ## skip 1991, which has missing values
                   n_max = 33,
                   col_names = col_names,
                   col_types = col_types) |>
  pivot_longer(cols = -time,
               names_to = c("sex", "age"),
               names_sep = "\\.") |>
  mutate(age = reformat_age(age),
         age = set_age_open(age, lower = 95)) |>
  mutate(time = as.integer(time)) |>
  count(age, sex, time, wt = value, name = "deaths")

saveRDS(deaths, file = .out)

