FROM alpine:3.17.0

RUN apk --update add sudo                                         && \
    apk --update add python3  openssl ca-certificates    && \
      python3 -m ensurepip && \
      rm -r /usr/lib/python*/ensurepip && \
      pip3 install --upgrade pip setuptools && \
      if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
      if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
      rm -r /root/.cache && \
    apk --update add --virtual build-dependencies python3-dev libffi-dev openssl-dev build-base  && \
    pip3 install --upgrade cffi                            && \
    pip3 install ansible                && \
    pip install --upgrade pycrypto pywinrm boto3    && \
    apk --update add sshpass openssh-client rsync  && \
    apk del build-dependencies            && \
    rm -rf /var/cache/apk/*               && \
    mkdir -p /etc/ansible                 && \
    echo 'localhost' > /etc/ansible/hosts

CMD [ "ansible-playbook", "--version" ]

