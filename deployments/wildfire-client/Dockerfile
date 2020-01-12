FROM node:10.16.0

RUN apt update -y

RUN apt install git -y
RUN apt install vim -y

RUN git clone https://github.com/vincentdu101/Wildfire-Analyzer-Predictor-System.git ./wildfire-client

WORKDIR wildfire-client/client

RUN npm install -g http-server
RUN npm install
RUN npm run build

WORKDIR build

EXPOSE 4000

CMD ["http-server", "-p", "4000"]