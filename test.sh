#!/bin/bash

has() {
  type "$1" > /dev/null 2>&1
  echo "in has "
}
echo "out has"

if has "rbenv"; then
  # 最新のRubyを入れる
  rbenv install --list | grep -v - | tail -n 1
  rbenv versions | tail -n 1 | cut -d' ' -f 2
fi

