#!/bin/bash

if [ -d ~/.go ]; then
  echo "already exists: ~/.go"
  exit 1
fi

path=$(cd $(dirname $0); pwd)

mkdir -p $path'/tmp'
cd $path'/tmp'

curl -LO https://go.dev/dl/go1.18.1.linux-amd64.tar.gz
tar -zxvf ./go1.18.1.linux-amd64.tar.gz

mv ./go ~/.go
cd $path
rm -r tmp

echo 'installed golang to ~/.go'
