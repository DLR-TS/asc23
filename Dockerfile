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
    





#ubuntu version
#RUN apt-get update -y && \ 
   # apt-get install cmake -y && \
    #apt-get install gcc -y && \
    #apt-get install git -y

# # get tools
#RUN git clone --config https.proxy=${https_proxy} https://github.com/modelica-tools/FMUComplianceChecker

