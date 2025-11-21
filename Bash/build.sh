#!/bin/bash
sudo docker rmi -f $(sudo docker images -q) ##this is not recommned step, i am deleting existing images to save space
sudo rm -r gold ## these steps are not recommened instead you can modify script as shown below
sudo mkdir gold
cd gold/
sudo git clone https://github.com/krishna1369/Gold_Site_Ecommerce.git
cd Day4-code/
sudo docker build -t react-image -f golddockerfile .
sudo docker tag react-image:latest krishna1369/react-repo:latest ##make sure you did docker login
sudo docker push krishna1369/react-repo:latest
