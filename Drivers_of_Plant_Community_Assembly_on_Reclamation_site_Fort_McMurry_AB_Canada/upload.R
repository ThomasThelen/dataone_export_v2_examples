library(dataone)
library(datapack)
library(uuid)

probable_cattle_node <- MNode("http://probable-cattle.nceas.ucsb.edu/metacat/d1/mn/v2")
# probable_cattle_node <- MNode("https://dev.nceas.ucsb.edu/knb/d1/mn/v2")
d1c <- D1Client(CNode("STAGING2"), probable_cattle_node)

data_package <- new("DataPackage")
f1_id = UUIDgenerate()
f2_id = UUIDgenerate()
f3_id = UUIDgenerate()
f4_id = UUIDgenerate()
f5_id = UUIDgenerate()
elm_id = UUIDgenerate()

f1 <- new("DataObject", id=f1_id, format="application/octet-stream", filename="./Abovegorund_Community.xlsx")
f2 <- new("DataObject", id=f2_id, format="application/octet-stream", filename="./DataEntry_PRS.csv")
f3 <- new("DataObject", id=f3_id, format="application/octet-stream", filename="./Seed_Bank_New.csv")
f4 <- new("DataObject", id=f4_id, format="application/octet-stream", filename="./SeedRain_2016.csv")
f5 <- new("DataObject", id=f5_id, format="application/octet-stream", filename="./Transects_Both_Years.csv")
f6 <- new("DataObject", id=elm_id, format="eml://ecoinformatics.org/eml-2.1.0", filename="./Drivers_of_Plant_Community_Assembly_on.xml")

data_package <- addMember(data_package, f1, f6)
data_package <- addMember(data_package, f2, f6)
data_package <- addMember(data_package, f3, f6)
data_package <- addMember(data_package, f4, f6)
data_package <- addMember(data_package, f5, f6)

myAccessRules <- data.frame(subject="https://orcid.org/0000-0002-1756-2128", permission="changePermission") 

packageId <- uploadDataPackage(d1c, data_package, public=FALSE, accessRules=myAccessRules, quiet=FALSE)
print(packageId)
