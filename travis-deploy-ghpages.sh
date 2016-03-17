#!/bin/bash

rev=$(git rev-parse --short HEAD)
repo_url="https://myhdl-bot:$GH_TOKEN@github.com/myhdl/site-myhdl-dev"
worktree_dir=~/build

# Travis has a very old version of git without worktree support.
# git worktree add -b gh-pages $worktree_dir origin/gh-pages
git clone -b gh-pages $repo_url $worktree_dir
rsync -avz --delete --exclude .git --exclude CNAME _build/ $worktree_dir/

cd $worktree_dir
if [[ -n $(git status -s) ]]; then
  git config user.name "MyHDL Bot"
  git config user.email "myhdl-bot@users.noreply.github.con"
  git commit --all -m "rebuild pages at ${rev}"
fi
