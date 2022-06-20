FROM alpine:latest

# install prerequisites
RUN apk update && \ 
    apk add cmake && \
    apk add gcc && \
    apk add git

# get
RUN git clone https://github.com/modelica-tools/FMUComplianceChecker

