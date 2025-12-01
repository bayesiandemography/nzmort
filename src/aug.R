
suppressPackageStartupMessages({
  library(bage)
  library(command)
})

cmd_assign(.mod = "out/mod.rds",
           .out = "out/aug.rds")

mod <- readRDS(.mod)

aug <- mod |>
  augment()

saveRDS(aug, file = .out)
