library(dataone)

package_id <- "resource_map_031d05fb-fbb5-41b8-ad86-2a25579ea8f2"
url <- "http://probable-cattle.nceas.ucsb.edu/metacat/d1/mn/v2"
# url <- "https://dev.nceas.ucsb.edu/knb/d1/mn/v2"

probable_cattle_node <- MNode(url)

d1c <- D1Client(CNode("STAGING2"), probable_cattle_node)
#pkg <- getDataPackage(d1c, id="urn:uuid:04cd34fd-25d4-447f-ab6e-73a572c5d383", quiet=FALSE)

# Get with datapack


# Download from Metacat
pkg <- getPackage(probable_cattle_node, id=package_id, format="application/bagit-100")
print(pkg)



package_url <- paste0(url, "/packages/application%2Fbagit-097", paste0("/", package_id))




paste("curl %s", package_url)



system(paste0("curl %s -H 'Authorization: Bearer %s' --output package.zip"), package_id, getOption("dataone_test_token"))






