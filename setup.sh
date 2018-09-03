#!/bin/sh
cd $(dirname $0)
for dotfile in .?*
do
    if [ $dotfile != '..' ] && [ $dotfile != '.git' ]
    then
        ln -Fis "$PWD/$dotfile" $HOME
    fi
done

DOTFILES=${HOME}/prj/dotfiles/.emacs.d/lisp

cd $DOTFILES

if [ ! -e $DOTFILES/anything/anything-config.el ];
then
    git clone https://github.com/emacsattic/anything
else
    echo 'The anything files are Existing ...  exit setup script.'
fi


