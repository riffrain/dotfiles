#!/bin/bash

path=$(cd $(dirname $0); pwd)

if [ -f ~/.agignore ]; then
  mv ~/.agignore ~/.agignore.orig
fi
ln -s $path'/../.agignore' ~/.agignore

