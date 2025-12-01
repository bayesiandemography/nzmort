
suppressPackageStartupMessages({
  library(readr)
  library(dplyr)
  library(tidyr)
  library(poputils)
  library(command)
})

cmd_assign(.popn = "data/DPE403905_20251130_103153_82.csv.gz",
           .out = "out/popn.rds")

age_labels <- age_labels(type = "single", max = 95)
col_names <- c("time",
               paste("Male", age_labels, sep = "."),
               paste("Female", age_labels, sep = "."))
col_types <- paste(rep(c("c", "i"), times = c(1, 2 * length(age_labels))),
                   collapse = "")

popn <- read_csv(.popn,
                 skip = 5, ## skip 1991, which has missing values
                 n_max = 33,
                 col_names = col_names,
                 col_types = col_types) |>
  pivot_longer(cols = -time,
               names_to = c("sex", "age"),
               names_sep = "\\.") |>
  mutate(age = reformat_age(age),
         age = combine_age(age, to = "lt")) |>
  mutate(time = as.integer(time)) |>
  count(age, sex, time, wt = value, name = "popn")

saveRDS(popn, file = .out)

