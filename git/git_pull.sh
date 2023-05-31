#!/bin/bash

/usr/bin/git pull

if [ $? -eq 0 ]; then
    echo "Update successful at [$(date -u +'%Y-%m-%d %H:%M:%S UTC')]" > $PWD/pull_at.html
else
    echo "Update failed at [$(date -u +'%Y-%m-%d %H:%M:%S UTC')]" > $PWD/pull_at.html
fi