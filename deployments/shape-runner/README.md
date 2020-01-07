# build the image
docker build -t shape-runner .

# run image
docker run -p 9000:9000/tcp shape-runner