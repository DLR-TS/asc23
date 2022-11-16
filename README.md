# Purpose
This repository provides a dockerfile that produces an image that includes the current testing tools for standard compliance

# Structure
- standards_reduced/ : holds all schema files from openDRIVE, openSCENARIO and SSP
- xmlSchemeChecker.py : generic script to check an xml against a provides schema
- requirements.txt : all requirements needed by python scripts in this repo
- Dockerfile : build instructions for the image
