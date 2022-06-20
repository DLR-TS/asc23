# FROM alpine:latest
FROM ubuntu:latest


# install prerequisites
#alpine version
# RUN apk update && \ 
#     apk add cmake && \
#     apk add gcc && \
#     apk add git


ubuntu version
RUN apt-get update -y && \ 
    apt-get install cmake -y && \
    apt-get install gcc -y && \
    apt-get install git -y

# # get tools
RUN git clone --config http.proxy=${http_proxy} https://github.com/modelica-tools/FMUComplianceChecker

