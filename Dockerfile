# FROM alpine:latest
FROM ubuntu:latest


# install prerequisites
#alpine version
# RUN apk update && \ 
#     apk add cmake && \
#     apk add gcc && \
#     apk add git

#ubuntu version
RUN apt update && \ 
    apt install cmake && \
    apt install gcc && \
    apt install git

# get
RUN git clone https://github.com/modelica-tools/FMUComplianceChecker

