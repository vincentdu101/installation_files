# build image
docker build -t flagship-server .

# run image as server
docker run -p 127.0.0.1:8080:8080/tcp flagship-server
