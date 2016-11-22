#!/bin/bash

set -e
if [[ $TRAVIS_BRANCH == 'master' ]] ; 
then
    cd site
    pwd
    git init
    git config user.name "Hervé Beraud"
    git config user.email "herveberaud.pro@gmail.com"
    git add .
    git status
    git commit -m "[site] Deploy"
    # We redirect any output to
    # /dev/null to hide any sensitive credential data that 
    # might otherwise be exposed.
    git push --force --quiet "https://${git_user}:${git_password}@${git_target}" gh-pages:gh-pages > /dev/null 2>&1
    echo "gh-pages updated"
else
    echo 'Invalid branch. You can only deploy from master.'
    exit 1
fi
