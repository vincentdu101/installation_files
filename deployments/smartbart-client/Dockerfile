FROM node:10.16.0

FROM node:10.16.0

RUN apt update -y

RUN apt install git -y
RUN apt install curl -y
RUN apt install vim -y

RUN git clone https://github.com/vincentdu101/SmartBart.git ./smartbart

WORKDIR ./smartbart/src/main/resources/static

RUN npm install -g http-server
RUN npm install
RUN npm run build

# WORKDIR build

EXPOSE 5000
CMD ["http-server", "-p", "5000", "./build"];