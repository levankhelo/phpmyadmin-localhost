#!/bin/bash


if [[ $(uname) == "Darwin" ]]; then
# on macos

    # if docker is not installed, install it
    if ! command -v docker > /dev/null; then
        brew install cask;
        brew cask install docker;

        # check if docker was successfuly installed
        if ! command -v docker > /dev/null; then
            echo failed to install docker;
            exit
        fi

        echo Docker installed successfully
    else
        echo Docker is already installed;
    fi

    # pulling image
    docker pull levankhelo/phpmyadmin:stable
else
# on other: linux

    # if docker is not installed, install it
    if ! command -v docker > /dev/null; then
        sudo apt-get update

        sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release;
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg;
        echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null;
        
        sudo apt-get update;

        sudo apt-get install docker-ce docker-ce-cli containerd.io;


        # check if docker was successfuly installed
        if ! command -v docker > /dev/null; then
            echo failed to install docker;
            exit
        fi

        echo Docker installed successfully
    else
        echo Docker is already installed;
    fi 
    
    # pulling image
    docker pull levankhelo/phpmyadmin:stable
    sudo docker pull levankhelo/phpmyadmin:stable
fi

