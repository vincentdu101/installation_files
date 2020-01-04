FROM node:10.16.0

RUN apt update -y

RUN apt install git -y
RUN apt install curl -y
RUN apt install vim -y

RUN git clone https://github.com/vincentdu101/FlagShip-Main.git ./flagship-server

WORKDIR flagship-server

RUN npm install

EXPOSE 8080
CMD ["node", "app.js"]