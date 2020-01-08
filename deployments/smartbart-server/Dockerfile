FROM adoptopenjdk/openjdk11:latest

RUN apt update -y

RUN apt install git -y
RUN apt install curl -y
RUN apt install vim -y
RUN apt install maven -y

RUN git clone https://github.com/vincentdu101/SmartBart.git ./smartbart-server

WORKDIR smartbart-server

RUN mvn clean install

EXPOSE 8083
CMD ["mvn", "spring-boot:run"]

