# pull base image
FROM alpine:3.9 as BASE

LABEL maintainer="amfortesramos@hotmail.com"

RUN echo "Add Python and certificate tools"                     && \
    apk --no-cache add python~2.7 py-pip openssl \
                ca-certificates                                 && \
    \
    echo "Upgrade pip and setuptools"                           && \
    pip install --upgrade pip setuptools                        && \
    \
    echo "Install build tools"                                  && \
    apk --no-cache add --virtual build-dependencies \
                python2-dev libffi-dev openssl-dev build-base   && \
    \
    echo "Install Ansible"                                      && \
    pip install ansible==2.7.11                                 && \
    \
    echo "Install required modules"                             && \
    pip install ansible-modules-hashivault netaddr jsonbender   && \
    \
    echo "Install required testing modules"                     && \
    pip install ansible-lint pytest yamllint                    && \
    \
    echo "Remove build tools (reduces size)"                    && \
    apk del build-dependencies                                  && \
    \
    echo "Add an empty hosts file"                              && \
    mkdir -p /etc/ansible                                       && \
    echo 'localhost' > /etc/ansible/hosts


# final production image
FROM BASE as PROD
# default command: display Ansible version
CMD [ "ansible", "--version" ]
