#!/bin/bash
#this script takes a single openDRIVE file and checks it schema validity against the below listed versions of the openDRIVE standard

ASC23_HOME=.
TESTFILE=$1

XODR170_SCHEMA=$ASC23_HOME/standards/openDRIVE/1.7.0/additional_content/uml_model/xsd_schema/localSchema/opendrive_17_core.xsd
XODR161_SCHEMA=$ASC23_HOME/standards/openDRIVE/1.6.1/xsd_schema/opendrive_16_core.xsd
XODR160_SCHEMA=$ASC23_HOME/standards/openDRIVE/1.6.0/xsd_schema/opendrive_16_core.xsd
XODR150_SCHEMA=$ASC23_HOME/standards/openDRIVE/1.5.0/OpenDRIVE_1.5_Schema_Files.xsd
XODR140_SCHEMA=$ASC23_HOME/standards/openDRIVE/1.4.0/OpenDRIVE_1.4H_Schema_Files.xsd

OUTPUT="Schema validity of ${TESTFILE}: \n"


OUTPUT+="openDRIVE 1.7: $(python3 $ASC23_HOME/xmlSchemeChecker.py $XODR170_SCHEMA $TESTFILE) \n"
OUTPUT+="openDRIVE 1.6.1: $(python3 $ASC23_HOME/xmlSchemeChecker.py $XODR161_SCHEMA $TESTFILE) \n"
OUTPUT+="openDRIVE 1.6: $(python3 $ASC23_HOME/xmlSchemeChecker.py $XODR160_SCHEMA $TESTFILE) \n"
OUTPUT+="openDRIVE 1.5: $(python3 $ASC23_HOME/xmlSchemeChecker.py $XODR150_SCHEMA $TESTFILE) \n"
OUTPUT+="openDRIVE 1.4: $(python3 $ASC23_HOME/xmlSchemeChecker.py $XODR140_SCHEMA $TESTFILE) \n"

echo -e "$OUTPUT"