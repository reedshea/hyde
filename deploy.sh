#!/bin/bash

set -o errexit -o nounset

if [ "$TRAVIS_BRANCH" != "master" ]
then
  echo "This commit was made against the $TRAVIS_BRANCH and not master. Not deploying."
  exit 0
fi

rev=$(git rev-parse --short HEAD)

cd _site

git init
git config user.name "Reed Shea"
git config user.email "reedshea@gmail.com"

git remote add upstream "https://$GITHUB_TOKEN@github.com/reedshea/cambridgeproduct.com"
git fetch upstream
git reset upstream/gh-pages

#echo "rustbyexample.com" > CNAME

touch .

git add -A .
git commit -m "rebuild pages at ${rev}"
git push -q upstream HEAD:gh-pages