#!/bin/bash
#this script takes a single openSCENARIO file and checks it schema validity against the below listed versions of the openSCENARIO standard

ASC23_HOME=.
TESTFILE=$1

XOSC12_SCHEMA=$ASC23_HOME/standards/openSCENARIO/openscenario-v1.2.0/Schema/OpenSCENARIO.xsd


OUTPUT="Schema validity of ${TESTFILE}: \n"


OUTPUT+="openSCENARIO 1.2: $(python3 $ASC23_HOME/xmlSchemeChecker.py $XOSC12_SCHEMA $TESTFILE) \n"



echo -e "$OUTPUT"