#!/bin/bash

if [[ $TRAVIS_BRANCH == 'master' ]]
then
     cd site
     jekyll build --destination out
else
    echo 'Invalid branch. You can only build from master.'
    exit 1
fi
