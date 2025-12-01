
COL_FILL = \#A6CEE3
COL_LINE = \#1F4E79
COL_POINT = \#D73027
COL_FILL_1 = \#A6D854
COL_LINE_1 = \#228B22
COL_FILL_2 = \#CC79A7
COL_LINE_2 = \#7E1E9C

.PHONY: all
all: out/fig_rates_direct.pdf


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
	Rscript $^ $@ 


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



## Clean

.PHONY: clean
clean:
	rm -rf out
	mkdir out
