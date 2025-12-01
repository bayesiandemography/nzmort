
COL_FEMALE := darkorange
COL_MALE := darkblue

.PHONY: all
all: out/fig_rates_direct.pdf \
     site


## Prepare data

out/deaths.rds: src/deaths.R \
  data/VSD349204_20251130_103448_2.csv.gz
	Rscript $^ $@

out/popn.rds: src/popn.R \
  data/DPE403905_20251130_103153_82.csv.gz
	Rscript $^ $@

out/data.rds: src/data.R \
  out/deaths.rds \
  out/popn.rds
	Rscript $^ $@


## Plots of raw data

out/fig_rates_direct.pdf: src/fig_rates_direct.R \
  out/data.rds
	Rscript $^ $@ --col_female=$(COL_FEMALE) \
                      --col_male=$(COL_MALE)


## Model

out/mod.rds: src/mod.R \
  out/data.rds
	Rscript $^ $@

out/aug.rds: src/aug.R \
  out/mod.rds
	Rscript $^ $@

out/lifeexp.rds: src/lifeexp.R \
  out/aug.rds
	Rscript $^ $@


## Website

.PHONY: site
site:  out/deaths.rds \
       out/popn.rds
	quarto render


## Clean

.PHONY: clean
clean:
	rm -rf out
	mkdir out
