# pull base image
FROM python:2.7-alpine

MAINTAINER Tony Fortes Ramos <amfortesramos@hotmail.com>

RUN echo "===> Installing sudo to emulate normal OS behavior..."  && \
    apk --update add sudo

RUN echo "===> Adding Python runtime..."  && \
    apk --update add python py-pip openssl ca-certificates    && \
    apk --update add --virtual build-dependencies \
                python-dev libffi-dev openssl-dev build-base  && \
    pip install --upgrade pip cffi
    
RUN echo "===> Installing Ansible..."  && \
    pip install ansible

RUN echo "===> Installing required networking tools..."  && \
    pip install jinja2 netaddr PyYAML pytest

RUN echo "===> Removing package list..."  && \
    apk del build-dependencies            && \
    rm -rf /var/cache/apk/*

RUN echo "===> Adding hosts for convenience..."  && \
    mkdir -p /etc/ansible                        && \
    echo 'localhost' > /etc/ansible/hosts


COPY ansible-playbook-wrapper /usr/local/bin/

ONBUILD  RUN  echo "===> Updating TLS certificates..."         && \
              apk --update add openssl ca-certificates

ONBUILD  WORKDIR  /tmp
ONBUILD  COPY  .  /tmp
ONBUILD  RUN  \
              echo "===> Diagnosis: host information..."  && \
              ansible -c local -m setup all

# default command: display Ansible version
CMD [ "ansible", "--version" ]


