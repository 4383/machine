#!/bin/bash

if [[ $TRAVIS_BRANCH == 'master' ]] ; 
then
    cd site/out
    git init
     
    git config user.name "Hervé Beraud"
    git config user.email "herveberaud.pro@gmail.com"
       
    git add .
    git commit -m "[site] Deploy"
         
    # We redirect any output to
    # /dev/null to hide any sensitive credential data that might otherwise be exposed.
    git push --force --quiet "https://${git_user}:${git_password}@${git_target}" gh-pages:gh-pages > /dev/null 2>&1
else
    echo 'Invalid branch. You can only deploy from master.'
    exit 1
fi
