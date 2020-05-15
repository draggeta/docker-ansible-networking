# Pull base image to build with
FROM alpine:3.9 as BUILD

RUN echo "Install dev packages"                                 && \
    apk add --no-cache build-base libffi-dev==3.2.1-r6  \
    openssl-dev==1.1.1g-r0 python3-dev==3.6.9-r2  \
    ca-certificates==20191127-r0

RUN echo "Upgrade pip and setuptools"                           && \
    python3 -m pip install --upgrade pip==20.1 setuptools==46.3.0  \
    wheel==0.34.2

RUN echo "Compile Ansible and linting tools"                    && \
    python3 -m pip wheel --wheel-dir=/root/wheels ansible==2.9.9

RUN echo "Compile static analysis tools"                        && \
    python3 -m pip wheel --wheel-dir=/root/wheels  \
    ansible-lint==4.2.0 pytest==5.4.2 yamllint==1.23.0



# Production image
FROM python:3.6-alpine

LABEL maintainer="amfortesramos@hotmail.com"
LABEL version="1.0"
LABEL description="Ansible-Networking Docker Image"

# Copy the artifacts over. Keeps the prod image small.
COPY --from=BUILD /root/wheels /root/wheels

RUN echo "Install compiled Python packages"                     && \
    python3 -m pip install --no-index --find-links=/root/wheels  \
    ansible ansible-lint pytest yamllint

RUN echo "Add an empty hosts file"                              && \
    mkdir -p /etc/ansible                                       && \
    echo 'localhost' > /etc/ansible/hosts

# Default command: display Ansible version
CMD [ "ansible", "--version" ]
