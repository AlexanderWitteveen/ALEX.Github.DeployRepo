#!/bin/bash -l

path=$(pwd)
keypath=$path/.sshkey
repopath=/targetrepo

echo "DEBUG 1"

echo "$INPUT_PRIVATE_KEY" > $keypath
chmod 600 $keypath

echo "DEBUG 2"

mkdir $repopath
chmod 777 $repopath

echo "DEBUG 3"

git clone "$INPUT_REPO_URL" --config core.sshCommand="ssh -i $keypath -o StrictHostKeyChecking=no" $repopath

echo "DEBUG 4"

#rm -rf $repopath/*
find $repopath/* -maxdepth 1
echo "DEBUG 4.1"
find $repopath/* -maxdepth 1 | grep -v ".git"
echo "DEBUG 4.2"

find $repopath/* -maxdepth 1 | grep -v ".git" | xargs rm -rf

echo "DEBUG 5"

cp -r ./src/* $repopath

ls -las $repopath

echo "DEBUG 6"

cd $repopath
echo "DEBUG 6.1"
git config --global user.name "$INPUT_USER_NAME"
echo "DEBUG 6.2"
git config --global user.email "$INPUT_USER_EMAIL"
echo "DEBUG 6.3"
git add -A 
echo "DEBUG 6.4"
git commit -m "$INPUT_COMMENT"
echo "DEBUG 6.5"
git push origin main

echo "DEBUG 7"

exit 0


