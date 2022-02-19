path=$(cd $(dirname $0); pwd)

if [ -f ~/.inputrc ]; then
  mv ~/.inputrc ~/.inputrc.orig
fi
ln -s $path'/../.inputrc' ~/.inputrc
