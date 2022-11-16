#!/bin/bash
#this script takes a single SSP file and checks it schema validity against the below listed versions of the SSP standard

ASC23_HOME=.
TESTFILE=$1

SSP1_SCHEMA=$ASC23_HOME/standards/SSP/SystemStructureDescription.xsd
SSP11_SCHEMA=$ASC23_HOME/standards/SSP/SystemStructureDescription11.xsd

OUTPUT="Schema validity of ${TESTFILE}: \n"


OUTPUT+="SSP 1.0: $(python3 $ASC23_HOME/xmlSchemeChecker.py $SSP1_SCHEMA $TESTFILE) \n"
OUTPUT+="SSP 1.1: $(python3 $ASC23_HOME/xmlSchemeChecker.py $SSP11_SCHEMA $TESTFILE) \n"


echo -e "$OUTPUT"