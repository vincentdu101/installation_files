FROM node:10.16.0

RUN apt update -y

RUN apt install git -y
RUN apt install vim -y

RUN git clone https://github.com/vincentdu101/human-pose-detection-3d.git ./shape-runner

WORKDIR shape-runner

RUN npm install -g http-server
RUN npm install
RUN npm run build

WORKDIR dist

EXPOSE 9000
CMD ["http-server", "-p", "9000"]