FROM node:10.16.0

RUN apt update -y

RUN apt install git -y
RUN apt install curl -y
RUN apt install vim -y

# install globally dependencies
RUN npm install -g typescript@3.2.4
RUN npm install -g yarn
RUN npm install -g @angular/cli --latest
RUN npm install -g http-server
RUN npm install -g babel-cli

# install and setup flagship-client
RUN git clone https://github.com/vincentdu101/flagship-client.git ./flagship-client

WORKDIR flagship-client
RUN git pull origin master
RUN npm i --save-dev typescript@3.2.4
RUN npm install
# RUN ng update --all --force
RUN ng build --prod

WORKDIR dist

EXPOSE 4200
CMD ["http-server", "-p", "4200"]