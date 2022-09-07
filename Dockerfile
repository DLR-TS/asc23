# Author(s): Danny Behnecke for Institute of Transportation System - German Aerospace Center

FROM alpine:3.16 AS base

ENV ASC23_HOME=/opt/asc32
RUN echo $ASC23_HOME


# install prerequisites
#alpine version
 RUN apk update && \ 
     apk --no-cache add --update cmake gcc git make clang clang-dev g++ libc-dev linux-headers
     

FROM base AS builder


#fetch all necessary resources


#FMU_COMPLIANCE_CHECKER
RUN mkdir -p $ASC23_HOME/FMU_COMPLIANCE_CHECKER; \
    git clone --config https.proxy=${https_proxy} https://github.com/modelica-tools/FMUComplianceChecker $ASC23_HOME/FMU_COMPLIANCE_CHECKER 
    
RUN cd $ASC23_HOME/FMU_COMPLIANCE_CHECKER; \
    mkdir build; \
    cd build; \
    cmake -DFMUCHK_INSTALL_PREFIX=${pwd}/../install ./../ ;\ 
    make install test 
    

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


FROM builder AS runner

ADD ./xmlSchemeChecker.py $ASC23_HOME/xmlSchemeChecker.py
ADD ./requirements.txt $ASC23_HOME/requirements.txt
RUN pip3 install -r $ASC23_HOME/requirements.txt

# TODO: slim down standards to compress image
COPY ./standards $ASC23_HOME/standards 
ADD ./check_openDRIVE.sh $ASC23_HOME/check_openDRIVE.sh
