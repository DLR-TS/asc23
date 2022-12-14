# Purpose
This repository provides a dockerfile that produces an image that includes the current testing tools for standard compliance

# Structure
- standards_reduced/ : holds all schema files from openDRIVE, openSCENARIO and SSP
- xmlSchemeChecker.py : generic script to check an xml against a provides schema
- requirements.txt : all requirements needed by python scripts in this repo
- Dockerfile : build instructions for the image

# Features
The container provides currently the following features:

	* Schema check for XML based standards (openDRIVE, openSCENARIO and SSP)
	* Installed [FMI Compliance Checker](https://github.com/modelica-tools/FMUComplianceChecker)
	* Ready-to-Use configuration for Gitlab-CI

# How To

## Schema Checking
For using ASC23 to check a bunch of XML-based standard artifacts for their schema compliance, one way to do it would be to put the files in to one folder / volume that is available to the container. Then, define an environment variable to contain all your desired files.

> Example for openDRIVE files
> XODR_FILES=$(find -name "*.xodr")


> Go through all openDRIVE files
> for FILE in $FILES; 
>   do 
>     $CI_PROJECT_DIR/check_openDRIVE.sh $FILE >> openDriveCheck.txt; 
>   done

## FMI Compliance Checker
> Disclaimer
> The official repository is also inconsistent with their nomenclature. The Standard's name is FMI, functional mockup interface. The artifact that can be checked is FMU, functional mockup unit. The project is called FMI Compliance Checker, while the software's name is FMU Compliance Checker.


The checker is installed in the container under $ASC23_HOME/FMU_COMPLIANCE_CHECKER. You can use it according to the tutorial on the Github Page.

