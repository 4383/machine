#!/bin/bash

if [[ $TRAVIS_BRANCH == 'master' ]]
then
     cd site
     jekyll build --destination out
fi
