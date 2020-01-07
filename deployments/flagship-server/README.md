# mongo needed to be a separate docker image
sudo docker pull mongo
sudo docker run -d -p 27017-27019:27017-27019 --name mongodb mongo

# build flagship-server image
docker build -t flagship-server .

# run it with the localhost as the host
sudo nohup docker run -p 127.0.0.1:8080:8080/tcp --network="host" -id flagship-server &