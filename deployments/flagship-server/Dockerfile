FROM node:10.16.0

RUN apt update -y

RUN apt install git -y
RUN apt install curl -y
RUN apt install vim -y

# setting up mongod db

# import mongo public key
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4

# create list source
RUN echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.0.list

# install mongodb
RUN apt-get install -y mongodb-org

# pin package to specific version
# "mongodb-org hold" | sudo dpkg --set-selections
# "mongodb-org-server hold" | sudo dpkg --set-selections
# "mongodb-org-shell hold" | sudo dpkg --set-selections
# "mongodb-org-mongos hold" | sudo dpkg --set-selections
# "mongodb-org-tools hold" | sudo dpkg --set-selections