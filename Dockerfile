# Author(s): Danny Behnecke for Institute of Transportation System - German Aerospace Center

FROM alpine:3.16 AS base

ENV ASC23_HOME=/opt/asc23
RUN echo $ASC23_HOME


# install prerequisites
#alpine version
 RUN apk update && \ 
     apk --virtual --no-cache add --update cmake gcc git make clang clang-dev g++ libc-dev linux-headers 
     
#fetch all necessary resources


#FMU_COMPLIANCE_CHECKER
RUN mkdir -p $ASC23_HOME/FMU_COMPLIANCE_CHECKER; \
    git clone --depth=1 --config https.proxy=${https_proxy} https://github.com/modelica-tools/FMUComplianceChecker $ASC23_HOME/FMU_COMPLIANCE_CHECKER_BUILD ; \
    mkdir $ASC23_HOME/FMU_COMPLIANCE_CHECKER ; \
    export DESTDIR=$ASC23_HOME/FMU_COMPLIANCE_CHECKER
    
RUN cd $ASC23_HOME/FMU_COMPLIANCE_CHECKER_BUILD; \
    mkdir build; \
    cd build; \
    cmake -DFMUCHK_INSTALL_PREFIX=${pwd}/../install ./../ ;\ 
    make install test
    
RUN cd $ASC23_HOME ;\
    rm -r $ASC23_HOME/FMU_COMPLIANCE_CHECKER_BUILD;\
    unset DESTDIR 

    

# Install python/pip
ENV PYTHONUNBUFFERED=1
RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools

# Initialize venv to encapsulate python packages
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"
RUN python3 -m pip install --upgrade pip

#OSI
RUN apk add --update --no-cache protobuf-dev protoc python3-dev

RUN mkdir -p $ASC23_HOME/OSI; \
    git clone --depth=1 --config https.proxy=${https_proxy} https://github.com/OpenSimulationInterface/open-simulation-interface.git $ASC23_HOME/OSI; \
    cd $ASC23_HOME/OSI; \
    python3 -m pip install .


#OSI_VALIDATOR
#@TODO The repo link has to be updated once the official osi-validation is installable again
RUN mkdir -p $ASC23_HOME/OSI_VALIDATOR; \
    #git clone --config https.proxy=${https_proxy} https://github.com/OpenSimulationInterface/osi-validation.git $ASC23_HOME/OSI_VALIDATOR 
    git clone --depth=1 --config https.proxy=${https_proxy} https://github.com/DLR-TS/osi-validation $ASC23_HOME/OSI_VALIDATOR 

RUN cd $ASC23_HOME/OSI_VALIDATOR; \
    git submodule update --init; \
    pip3 install --use-deprecated=legacy-resolver .



FROM python:3-alpine AS runner

ENV ASC23_HOME=/opt/asc23

COPY --from=base $ASC23_HOME $ASC23_HOME

COPY ./xmlSchemeChecker.py $ASC23_HOME/xmlSchemeChecker.py
COPY ./requirements.txt $ASC23_HOME/requirements.txt
RUN pip3 install -r $ASC23_HOME/requirements.txt

# TODO: slim down standards to compress image
COPY ./standards_reduced $ASC23_HOME/standards 
COPY ./check_openDRIVE.sh $ASC23_HOME/check_openDRIVE.sh

