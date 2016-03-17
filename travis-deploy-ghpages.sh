#!/bin/bash

rev=$(git rev-parse --short HEAD)
repo_url="https://myhdl-bot:$GH_TOKEN@github.com/myhdl/site-myhdl-dev.git"
pages_dir=~/myhdl/ghpages

git clone -b gh-pages $repo_url $pages_dir
rsync -avz --delete --exclude .git --exclude CNAME _build/ $pages_dir/

cd $pages_dir
if [[ -n $(git status -s) ]]; then
  git config user.name "MyHDL Bot"
  git config user.email "myhdl-bot@users.noreply.github.con"
  git config push.default simple
  git commit --all -m "rebuild pages at ${rev}"
  git push -q
fi
