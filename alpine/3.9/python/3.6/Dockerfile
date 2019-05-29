# pull base image
FROM alpine:3.9 as BASE

LABEL maintainer="amfortesramos@hotmail.com"

RUN echo "Add Python and certificate tools"                     && \
    apk --no-cache add python3~3.6 openssl ca-certificates      && \
    if [[ ! -e /usr/bin/python ]]; \
    then ln -sf /usr/bin/python3 /usr/bin/python; \
    fi                                                          && \
    \
    echo "Upgrade pip and setuptools"                           && \
    pip3 install --upgrade pip setuptools                       && \
    if [ ! -e /usr/bin/pip ]; \
    then ln -sf /usr/bin/pip3 /usr/bin/pip; \
    fi                                                          && \
    \
    echo "Install build tools"                                  && \
    apk --no-cache add --virtual build-dependencies \
                python3-dev libffi-dev openssl-dev build-base   && \
    \
    echo "Install Ansible"                                      && \
    pip install ansible==2.7.10                                 && \
    \
    echo "Install required modules"                             && \
    pip install ansible-modules-hashivault netaddr jsonbender \
                pyvalid                                         && \
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
