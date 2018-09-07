#!/bin/bash
set -ev


# get clone master
git clone https://${GH_REF} .deploy_git
cd .deploy_git

# Use sed to replace the SSH URL with the public URL if .gitmodules exists
if [ -e ".gitmodules" ]; then
    sed -i 's/git@github.com:/https:\/\/github.com\//' .gitmodules
fi
# update the submodule in repo by manual
git submodule update --init --recursive

git checkout master

cd ../
mv .deploy_git/.git/ ./public/

cd ./public

git config user.name "Akkuman"
git config user.email "akkumans@qq.com"

# add commit timestamp
git add .
git commit -m "Travis CI Auto Builder at `date +"%Y-%m-%d %H:%M"`"

# Github Pages
git push --force --quiet "https://${GITHUB_TOKEN}@${GH_REF}" master:master

# Coding Pages
git push --force --quiet "https://Akkuman:${CODING_TOKEN}@${CD_REF}" master:master