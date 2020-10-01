library(dataone)
library(datapack)
library(uuid)

probable_cattle_node <- MNode("http://probable-cattle.nceas.ucsb.edu/metacat/d1/mn/v2")
# probable_cattle_node <- MNode("https://dev.nceas.ucsb.edu/knb/d1/mn/v2")
d1c <- D1Client(CNode("STAGING2"), probable_cattle_node)

data_package <- new("DataPackage")

# Files in data/
plot <- new("DataObject", id=UUIDgenerate(), format="application/octet-stream", filename="plot.py", targetPath="plot.py")
soil_temp <- new("DataObject", id=UUIDgenerate(), format="application/octet-stream", filename="inputs/daily-total-female-births.csv", targetPath="inputs/daily-total-female-births.csv")
vege_class<- new("DataObject", id=UUIDgenerate(), format="application/octet-stream", filename="outputs/female-daily-births.png", targetPath="outputs/female-daily-births.png")

# Science Metadata
science_metadata <- new("DataObject", id=UUIDgenerate(), format="eml://ecoinformatics.org/eml-2.0.0", filename="eml.xml")

# Add data
data_package <- addMember(data_package, plot, science_metadata)
data_package <- addMember(data_package, soil_temp, science_metadata)
data_package <- addMember(data_package, vege_class, science_metadata)

myAccessRules <- data.frame(subject="https://orcid.org/0000-0002-1756-2128", permission="changePermission") 

packageId <- uploadDataPackage(d1c, data_package, public=TRUE, accessRules=myAccessRules, quiet=FALSE)
print(packageId)
