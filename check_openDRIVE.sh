#!/bin/bash
ASC23_HOME=/opt/asc32
XODR170_SCHEMA = $ASC23_HOME/standards/openDRIVE/1.7.0/additional_content/uml_model/xsd_schema/localSchema/opendrive_17_core.xsd
XODR161_SCHEMA = $ASC23_HOME/standards/openDRIVE/1.6.1/xsd_schema/opendrive_16_core.xsd
XODR160_SCHEMA = $ASC23_HOME/standards/openDRIVE/1.6.0/xsd_schema/opendrive_16_core.xsd
XODR150_SCHEMA = $ASC23_HOME/standards/openDRIVE/1.5.0/OpenDRIVE_1.5_Schema_Files.xsd
XODR140_SCHEMA = $ASC23_HOME/standards/openDRIVE/1.4.0/OpenDRIVE_1.4H_Schema_Files.xsd




python3 $ASC23_HOME/xmlSchemeChecker.py $XODR170_SCHEMA $ASC23_HOME/standards/1.7.0//examples_and_use_cases/UC_Simple-X-Junction/UC_Simple-X-Junction.xodr