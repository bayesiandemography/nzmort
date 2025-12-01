
suppressPackageStartupMessages({
  library(dplyr)
  library(command)
})

cmd_assign(.deaths = "out/deaths.rds",
           .popn = "out/popn.rds",
           .out = "out/data.rds")

deaths <- readRDS(.deaths)
popn <- readRDS(.popn)

data <- inner_join(deaths, popn, by = c("age", "sex", "time"))

saveRDS(data, file = .out)
