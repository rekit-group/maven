#!/bin/bash

if [ "$TRAVIS_BRANCH" != "master" ]; then
	echo "Skipping as not branch master"
	exit 1
fi

: "${MAVEN_PASSWD?Need to set MAVEN_PASSWD}"

cd /tmp

echo "Ok found password ..."
curl -O https://raw.githubusercontent.com/rekit-group/maven/releases/travis/id_rsa.enc

openssl aes-256-cbc -a -salt -k "$MAVEN_PASSWD" -out id_rsa -in id_rsa.enc -d

if [ ! -f id_rsa ]; then
	echo "Decryption failed!"
	exit 1
fi

mkdir -p ~/.ssh/
mv id_rsa ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa

git config --global user.email "travis-ci@fuchss.org"
git config --global user.name "Travis-CI"
