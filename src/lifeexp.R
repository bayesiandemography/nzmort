
suppressPackageStartupMessages({
  library(dplyr)
  library(poputils)
  library(command)
})

cmd_assign(.aug = "out/aug.rds",
           .out = "out/lifeexp.rds")

aug <- readRDS(.aug)

lifeexp <- aug |>
  lifeexp(mx = .fitted,
          at = c(0, 65),
          sex = sex,
          by = time,
          n_core = 12)

saveRDS(lifeexp, file = .out)

