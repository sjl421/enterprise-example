#!/bin/bash -e

if [ -z "$DEMO_NAME" ]; then
  echo DEMO_NAME is not specified
  exit 1
fi

echo Configuring Enterprise Example demo $DEMO_NAME

./ec2.py --refresh-cache 2>&1 > /dev/null
ansible-playbook --key-file /dev/shm/id_rsa -i ec2.py -u core plays/configure.yml
