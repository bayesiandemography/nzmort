
suppressPackageStartupMessages({
  library(bage)
  library(dplyr)
  library(command)
})

cmd_assign(.data = "out/data.rds",
           .out = "out/mod.rds")

data <- readRDS(.data)

mod <- mod_pois(deaths ~ age * sex * time,
                data = data,
                exposure = popn) |>
  set_prior(age ~ RW2_Infant()) |>
  set_prior(sex ~ NFix()) |>
  set_prior(time ~ RW2()) |>
  set_prior(age:sex ~ RW2()) |>
  set_prior(age:time ~ RW2(con = "by")) |>
  set_prior(sex:time ~ RW2(con = "by")) |>
  set_prior(age:sex:time ~ RW2(con = "by")) |>
  set_confidential_rr3() |>
  set_n_draw(n_draw = 2000) |>
  fit()

print(mod)

saveRDS(mod, file = .out)

