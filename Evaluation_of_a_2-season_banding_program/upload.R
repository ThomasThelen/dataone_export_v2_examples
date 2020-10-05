library(dataone)
library(datapack)
library(uuid)

probable_cattle_node <- MNode("http://probable-cattle.nceas.ucsb.edu/metacat/d1/mn/v2")
# probable_cattle_node <- MNode("https://dev.nceas.ucsb.edu/knb/d1/mn/v2")
d1c <- D1Client(CNode("STAGING2"), probable_cattle_node)

data_package <- new("DataPackage")

# Files in data/
# Skipped due to the large file size
# data_for_abdu_ms <- new("DataObject", id=UUIDgenerate(), format="application/octet-stream", filename="data/data_for_abdu_ms.csv", targetPath="data/data_for_abdu_ms.csv")

# Files in modeling/
browniems_speffect <- new("DataObject", id=UUIDgenerate(), format="application/octet-stream", filename="modeling/browniems_speffect.Rmd", targetPath="modeling/browniems_speffect.Rmd")
plotAndSumsSpEffect<- new("DataObject", id=UUIDgenerate(), format="application/octet-stream", filename="modeling/plotAndSumsSpEffect.R", targetPath="modeling/plotAndSumsSpEffect.R")
run_all_models <- new("DataObject", id=UUIDgenerate(), format="application/octet-stream", filename="modeling/run_all_models.R", targetPath="modeling/run_all_models.R")
runBrownieSpEffect <- new("DataObject", id=UUIDgenerate(), format="application/octet-stream", filename="modeling/runBrownieSpEffect.R", targetPath="modeling/runBrownieSpEffect.R")
runSingleSeasonBrownieSpEffect <- new("DataObject", id=UUIDgenerate(), format="application/octet-stream", filename="modeling/runSingleSeasonBrownieSpEffect.R", targetPath="modeling/runSingleSeasonBrownieSpEffect.R")

# Files in /scripts
AgeSex_1seasonpost_annS_spEffect <- new("DataObject", id=UUIDgenerate(), format="application/octet-stream", filename="scripts/AgeSex_1seasonpost_annS_spEffect.txt", targetPath="scripts/AgeSex_1seasonpost_annS_spEffect.txt")
AgeSex_1seasonpre_annS_spEffect <- new("DataObject", id=UUIDgenerate(), format="application/octet-stream", filename="scripts/AgeSex_1seasonpre_annS_spEffect.txt", targetPath="scripts/AgeSex_1seasonpre_annS_spEffect.txt")
AgeSex_2season_annS_spEffect_Small <- new("DataObject", id=UUIDgenerate(), format="application/octet-stream", filename="scripts/AgeSex_2season_annS_spEffect_Small.txt", targetPath="scripts/AgeSex_2season_annS_spEffect_Small.txt")

# Science Metadata
science_metadata <- new("DataObject", id=UUIDgenerate(), format="eml://ecoinformatics.org/eml-2.0.0", filename="Evaluation_of_a_2_season_banding_program_to.xml")

# Add data
#data_package <- addMember(data_package, data_for_abdu_ms, science_metadata)

# Add for modeling
data_package <- addMember(data_package, browniems_speffect, science_metadata)
data_package <- addMember(data_package, plotAndSumsSpEffect, science_metadata)
data_package <- addMember(data_package, run_all_models, science_metadata)
data_package <- addMember(data_package, runBrownieSpEffect, science_metadata)
data_package <- addMember(data_package, runSingleSeasonBrownieSpEffect, science_metadata)

# Add for scripts
data_package <- addMember(data_package, AgeSex_1seasonpost_annS_spEffect, science_metadata)
data_package <- addMember(data_package, AgeSex_1seasonpre_annS_spEffect, science_metadata)
data_package <- addMember(data_package, AgeSex_2season_annS_spEffect_Small, science_metadata)

myAccessRules <- data.frame(subject="https://orcid.org/0000-0002-1756-2128", permission="changePermission") 

packageId <- uploadDataPackage(d1c, data_package, public=TRUE, accessRules=myAccessRules, quiet=FALSE)
print(packageId)
