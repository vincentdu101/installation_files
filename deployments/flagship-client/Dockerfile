From node:10.16.0

RUN apt update -y

RUN apt install git -y
RUN apt install curl -y


RUN git clone https://github.com/vincentdu101/installation_files.git

# install globally dependencies
RUN npm install -g yarn
RUN npm install -g typescript
RUN npm install -g @angular/cli --latest
RUN npm install -g http-server
RUN npm install -g babel-cli

# install and setup flagship-client
RUN git clone https://github.com/vincentdu101/flagship-client.git /flagship-client
RUN cd /flagship-client
RUN yarn
RUN ng build --prod