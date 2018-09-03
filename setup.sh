#!/bin/sh
cd $(dirname $0)
for dotfile in .?*
do
    if [ $dotfile != '..' ] && [ $dotfile != '.git' ]
    then
        ln -Fis "$PWD/$dotfile" $HOME
    fi
done

USER=masoo
DOTFILES=${HOME}/prj/dotfiles/.emacs.d/lisp

echo ${USER}
echo $DOTFILES

# cd ~${USER}/prj/dotfiles
if [ -e $DOTFILES ];
then
  cd $DOTFILES
else
    echo 'No anything directory...'
    exit
fi

echo $DOTFILES

if [ ! -e $DOTFILES/anything/anything-config.el ];
then
    git clone https://github.com/emacsattic/anything
else
    echo 'Existing the anything files...  exit setup script.'
fi


