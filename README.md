# Ansible-Networking Docker Images

[![Docker Automated build](https://img.shields.io/docker/automated/draggeta/ansible-networking.svg?style=flat-square)](https://hub.docker.com/r/draggeta/ansible-networking/)
[![Docker Pulls](https://img.shields.io/docker/pulls/draggeta/ansible-networking.svg?style=flat-square)](https://hub.docker.com/r/draggeta/ansible-networking/)

This repository contains Dockerfiles to build Ansible container images. These images can be used for testing purposes such as unit-tests and validation/linting of yaml/python files.

The focus of these images are on networking, but they should be usable for most other usecases.

For now the images consist of Alpine 3.8 as the base, with Python 2 or 3 layered on top. Ansible and the networking tools are added on top of these.

## Extra packages

* pytest - Runs doc and unit tests
* yamllint - Validates yaml files for syntax and style
* ansible-lint - Validates and Ansible files for syntax and style
