## Demo Packages
This repository holds a bank of test datasets. Most of them illustrate a particular aspect of the DataONE download format while other give common formats.

## Uploading & Downloading
In each folder, there's a file for uploading and downloading the data package.
The uploading is done using `datapack`, downloading is done with a curl command in `download.sh`. All of the datasets are public, so visiting the URL in the first portion of the cURL command will suffice (you'll want to connect to the VPN).

### Prerequisites

1. Add your token to RStudio the standard way
2. Connect to the UCSB VPN

## Folders

`input-output/`: A basic package showing package struture

`Evaluation_of_a_2-season_banding_program_to_estimate_seasonal_and_annual_survival_probabilities`: Uses prov:atLocation to specify the directories

`datacite/`: An example of a package using the datacite format

`eml/`: An exmple of a package using the eml format

### Pending

`two-science-metadata/`: A package with two data files, each described by a different EML document

`nested-package/`: A nested package, reframed with prov:atLocation

`mets/`: An example of a package using the METS metadata format

`test-tale/`: A Tale downlaoded from Whole Tale


### `input-output`
This is a small package with three user files: `daily-total-female-births.csv`, `plot.py`, and `female-daily-births.png`. There's an included EML document. The file 
locations are all documented in R.

### `eml`

This dataset came from [DataONE](https://search.dataone.org/view/doi%3A10.18739%2FA2736M31X0). A folder structure was added to it to show what similiar datasets will look like in the future.
