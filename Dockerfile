# FROM alpine:latest
FROM ubuntu:latest


# install prerequisites
#alpine version
# RUN apk update && \ 
#     apk add cmake && \
#     apk add gcc && \
#     apk add git

#ubuntu version
RUN apt update -y && \ 
    apt install cmake -y && \
    apt install gcc -y && \
    apt install git -y

# get
RUN git clone https://github.com/modelica-tools/FMUComplianceChecker

