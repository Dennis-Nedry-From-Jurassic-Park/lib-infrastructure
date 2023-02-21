#!/bin/bash
set -x
# https://askubuntu.com/questions/720260/updating-golang-on-ubuntu
# https://khongwooilee.medium.com/how-to-update-the-go-version-6065f5c8c3ec
sudo apt-get remove golang-go -y
sudo apt-get remove --auto-remove golang-go -y
sudo rm -rvf /usr/local/go

wget https://dl.google.com/go/go1.19.4.linux-amd64.tar.gz
sudo tar -xvf go1.19.4.linux-amd64.tar.gz

sudo mv go /usr/local


export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

source ~/.profile
