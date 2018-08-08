# pull base image
FROM williamyeh/ansible:alpine3

MAINTAINER Tony Fortes Ramos <amfortesramos@hotmail.com>

RUN echo "===> Installing required software..."  && \
    pip install jinja2 netaddr PyYAML pytest 
