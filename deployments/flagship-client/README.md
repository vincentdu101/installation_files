# Build Image
docker build -t flagship-client .

# Run Docker image
docker run -it --entrypoint=/bin/sh flagship-client:latest