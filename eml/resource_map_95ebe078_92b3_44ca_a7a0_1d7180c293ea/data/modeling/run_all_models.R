#### Script for running full Brownie model for all 3 species with Bayesian p-values, plus single-season models
## **Change working directory**
setwd("C:/Users/Robbie/Desktop/dissertation/blackducks/bayesian_p_value_jar/")
# Load processed data
rull.2 <- read.csv("data_for_abdu_ms.csv")
# Load functions to run processed data
source("runBrownieSpEffect.R")
source("runSingleSeasonBrownieSpEffect.R")
# Load JAGS files
JAGSMdlSpEffect <- paste(readLines("AgeSex_2season_annS_spEffect_Small.txt"),collapse="\n")
JAGSMdlPreSpEffect <- paste(readLines("AgeSex_1seasonpre_annS_spEffect.txt"),collapse="\n")
JAGSMdlPostSpEffect <- paste(readLines("AgeSex_1seasonpost_annS_spEffect.txt"),collapse="\n")
# Run two-season model
sims.out.allspp <- runBrownieSpEffect(full.2, pooledHybrids=T, JAGSMdlSpEffect)
# Run single-season models
sims.out.preSS <- runSingleSeasonBrownieSpEffect(full.2, pooledHybrids=pooledH, JAGSMdlPreSpEffect, season="Pre")
sims.out.postSS <- runSingleSeasonBrownieSpEffect(full.2, pooledHybrids=pooledH, JAGSMdlPostSpEffect, season="Post")
