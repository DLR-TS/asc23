FROM alpine:latest AS base
#FROM ubuntu:latest


# install prerequisites
#alpine version
 RUN apk update && \ 
     apk --no-cache add --update cmake gcc git make clang clang-dev g++ libc-dev linux-headers
     

FROM base AS builder


#fetch all necessary resources


#FMU_COMPLIANCE_CHECKER
RUN mkdir /usr/src/; \
    cd /usr/src; \
    git clone --config https.proxy=${https_proxy} https://github.com/modelica-tools/FMUComplianceChecker; 
    
RUN cd /usr/src/FMUComplianceChecker; \
    mkdir build; \
    cd build; \
    cmake -DFMUCHK_INSTALL_PREFIX=${pwd}/../install ./../ ;\ 
    make install test 
    

# Install python/pip
ENV PYTHONUNBUFFERED=1
RUN apk add --update --no-cache python3 && ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools


FROM builder AS runner

ADD ./xmlSchemeChecker.py /opt/xmlSchemeChecker/xmlSchemeChecker.py

#ubuntu version
#RUN apt-get update -y && \ 
   # apt-get install cmake -y && \
    #apt-get install gcc -y && \
    #apt-get install git -y

# # get tools
#RUN git clone --config https.proxy=${https_proxy} https://github.com/modelica-tools/FMUComplianceChecker

