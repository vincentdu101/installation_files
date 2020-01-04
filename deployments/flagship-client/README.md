# Build Image
docker build -t flagship-client .

# Build Image with no cache
docker build --no-cache -t flagship-client .

# Run Docker image
docker run -i -t flagship-client:latest /bin/bash

# Delete Images
docker rmi -f $(docker images -aq)

# Remove dangling images
docker images purge

# Remove everything 
docker system prune