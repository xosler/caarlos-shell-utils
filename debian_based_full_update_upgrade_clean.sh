#!/bin/bash

sudo apt-get update
sudo apt-get install -f -y
sudo apt-get autoremove -y
sudo apt-get upgrade -y
sudo apt-get autoclean -y
