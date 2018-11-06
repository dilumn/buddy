#!/bin/bash
ssh -t -t dilumn@10.101.1.20 << EOF
cd /home/dilumn/buddy
git branch --set-upstream-to=origin/master master
git pull
git checkout master
bundle install --path vendor/bundle
thin stop
thin start -d
exit
EOF