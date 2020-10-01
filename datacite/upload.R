library(dataone)
library(datapack)
library(uuid)

probable_cattle_node <- MNode("http://probable-cattle.nceas.ucsb.edu/metacat/d1/mn/v2")
# probable_cattle_node <- MNode("https://dev.nceas.ucsb.edu/knb/d1/mn/v2")
d1c <- D1Client(CNode("STAGING2"), probable_cattle_node)

data_package <- new("DataPackage")

# Files in data/
bb_zscorepreds <- new("DataObject", id=UUIDgenerate(), format="application/octet-stream", filename="bb_zscorepreds.R", targetPath="./data/bb_zscorepreds.R")
bbstanleadin_knb <- new("DataObject", id=UUIDgenerate(), format="application/octet-stream", filename="bbstanleadin_knb.R", targetPath="./data/bbstanleadin_knb.R")
flags_for_models <- new("DataObject", id=UUIDgenerate(), format="application/octet-stream", filename="flags_for_models_knb.R", targetPath="./data/flags_for_models_knb.R")
models_stan_knb <- new("DataObject", id=UUIDgenerate(), format="application/octet-stream", filename="models_stan_knb.R", targetPath="./data/models_stan_knb.R")
ospreebb_forknb <- new("DataObject", id=UUIDgenerate(), format="application/octet-stream", filename="ospreebb_forknb.csv", targetPath="./data/ospreebb_forknb.csv")

# Files in models/
speciescomplex_multcues <- new("DataObject", id=UUIDgenerate(), format="application/octet-stream", filename="speciescomplex_multcues.R", targetPath="./models/speciescomplex_multcues.R")
speciescomplex_nocrops <- new("DataObject", id=UUIDgenerate(), format="application/octet-stream", filename="speciescomplex_nocrops.R", targetPath="./models/speciescomplex_nocrops.R")
speciescomplex <- new("DataObject", id=UUIDgenerate(), format="application/octet-stream", filename="speciescomplex.R", targetPath="/models/speciescomplex.R")

# Science Metadata
science_metadata <- new("DataObject", id=UUIDgenerate(), format="http://datacite.org/schema/kernel-3.0", filename="Observed_Spring_Phenology_Responses_in.xml")

# Add data
data_package <- addMember(data_package, bb_zscorepreds, science_metadata)
data_package <- addMember(data_package, bbstanleadin_knb, science_metadata)
data_package <- addMember(data_package, flags_for_models, science_metadata)
data_package <- addMember(data_package, models_stan_knb, science_metadata)
data_package <- addMember(data_package, ospreebb_forknb, science_metadata)

# Add models
data_package <- addMember(data_package, speciescomplex_multcues, science_metadata)
data_package <- addMember(data_package, speciescomplex_nocrops, science_metadata)
data_package <- addMember(data_package, speciescomplex, science_metadata)

myAccessRules <- data.frame(subject="https://orcid.org/0000-0002-1756-2128", permission="changePermission") 

packageId <- uploadDataPackage(d1c, data_package, public=TRUE, accessRules=myAccessRules, quiet=FALSE)
print(packageId)
