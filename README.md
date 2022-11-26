# Docker image for Ansible based on Alpine

[![Docker pipeline workflow](https://github.com/exaspace/docker-ansible/actions/workflows/main.yml/badge.svg)](https://github.com/exaspace/docker-ansible/actions/workflows/main.yml)


  docker pull exaspace/ansible

Run an Ansible playbook in the current directory:

  docker run --rm -v $PWD:/work -w /work exaspace/ansible ansible-playbook my-playbook.yml

* Small image size (roughly 150MB).
* The image is rebuilt every week to ensure security updates and latest versions are applied


## Contains 

* ansible
* openssl
* boto3 - so the Ansible AWS modules will work. You may want to mount your AWS credentials into the container with `-v $HOME/.aws:/root/.aws:ro` or use environment variables such as `-e AWS_ACCESS_KEY_ID=xxx` etc. 
