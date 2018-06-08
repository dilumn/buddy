#!/bin/bash
ssh -t -t dilumn@10.101.1.20 << EOF
cd /home/dilumn/buddy
git branch --set-upstream-to=origin/master master
git pull
git checkout master
docker-compose -f production.yml build
docker-compose stop
docker-compose rm -f
docker-compose -f production.yml up -d
exit
EOF
