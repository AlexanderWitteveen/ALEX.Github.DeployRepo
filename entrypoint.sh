#!/bin/bash -l

path=$(pwd)
keypath=$path/.sshkey
repopath=/targetrepo

echo "$INPUT_PRIVATE_KEY" > $keypath
chmod 600 $keypath

mkdir $repopath
chmod 777 $repopath

git clone "$INPUT_REPO_URL" --config core.sshCommand="ssh -i $keypath -o StrictHostKeyChecking=no" $repopath

#rm -rf $repopath/*
find $repopath/* -maxdepth 1
find $repopath/* -maxdepth 1 | grep -v ".git"

find $repopath/* -maxdepth 1 | grep -v ".git" | xargs rm -rf

cp -r $INPUT_SOURCE/* $repopath

ls -las $repopath

cd $repopath
git config --global user.name "$INPUT_USER_NAME"
git config --global user.email "$INPUT_USER_EMAIL"
git add -A
git commit -m "$INPUT_COMMENT"
if [[ ! -z "$INPUT_TAG" ]]; then
    git tag "$INPUT_TAG"
    echo $?
    if [[ $? -gt 0 ]]; then
        exit 1
    fi
fi
git push --tags origin main

exit 0

