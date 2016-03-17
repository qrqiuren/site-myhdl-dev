#!/bin/bash

#NOTE: GH_TOKEN is a secret variable. DO NOT echo it anywhere.
msg=$(git log -1 --format="rebuild pages at %h%nAuthor: %an%n%B")
echo "$msg"
repo_url="https://myhdl-bot:$GH_TOKEN@github.com/myhdl/site-myhdl-dev.git"
pages_dir=~/myhdl/ghpages

git clone -b gh-pages $repo_url $pages_dir
rsync -az --delete --exclude .git --exclude CNAME _build/ $pages_dir/

cd $pages_dir
if [[ -z $(git status -s) ]]; then
  echo "No changes. Exiting."
  exit
fi

git config user.name "MyHDL Bot"
git config user.email "myhdl-bot@users.noreply.github.com"
git config push.default simple
git commit --all -m "rebuild pages at ${msg}"
git push -q
