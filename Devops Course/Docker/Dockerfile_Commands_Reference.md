1. `FROM`
Purpose:
Specifies the base image to use for creating the Docker image.
```Dockerfile
# Use the official Python image as the base
FROM python:3.9-slim
# Set the working directory inside the container
WORKDIR /app
# Copy the local requirements.txt file to the working directory in the container
COPY requirements.txt .
# Add a tar file and extract it to the working directory
ADD my_archive.tar.gz /app/
# Install dependencies listed in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt
# Run the Flask application
CMD ["python", "app.py"]
# Set the entry point to a shell script
ENTRYPOINT ["/entrypoint.sh"]
# Expose port 80 for the web server
EXPOSE 80
# Set an environment variable for the application
ENV APP_ENV=production
# Define a volume to persist data
VOLUME /data
# Define a build argument with a default value
ARG APP_VERSION=1.0.0
# Switch to a non-root user
USER appuser
# Add a label to the image
LABEL maintainer="yourname@example.com"
# Set the stop signal to SIGINT
STOPSIGNAL SIGINT
# Add a health check to verify the container is running
HEALTHCHECK CMD curl --fail http://localhost:8080/health || exit 1
# Use Bash as the default shell
SHELL ["/bin/bash", "-c"]
# Add an ONBUILD instruction to copy files
ONBUILD COPY . /app
# Use ENTRYPOINT to set the main command and CMD for default arguments
ENTRYPOINT ["python"]
CMD ["app.py"]
19. MULTI-STAGE BUILDS
#Reduces the size of the final image by using multiple FROM statements in a single Dockerfile.

# Stage 1: Build the application
FROM node:14-alpine as builder

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

# Stage 2: Production environment
FROM node:14-alpine

WORKDIR /app
COPY --from=builder /app .
CMD ["node", "server.js"]
```
## Dockerfile Commands Table

| Command       | Description                                                                                  |
|---------------|----------------------------------------------------------------------------------------------|
| `FROM`        | Specify the Docker image name to build your image from.                                       |
| `MAINTAINER`  | Specify the person who creates the Docker image.                                              |
| `CMD`         | Execute commands when your Docker image is deployed.                                          |
| `RUN`         | Execute commands during the image build process.                                              |
| `LABEL`       | Specify metadata information of the Docker image.                                             |
| `EXPOSE`      | Specify the network port for the Docker container.                                            |
| `ENV`         | Set environment variables with key and value.                                                 |
| `ARG`         | Set environment variables with key and value during the image build.                          |
| `ADD`         | Copy files and directories from your host to the Docker image.                                |
| `COPY`        | Copy files or directories from your host to the Docker image.                                 |
| `ENTRYPOINT`  | Specify commands that will execute when the Docker container starts.                          |
| `VOLUME`      | Create or mount a volume to the Docker container.                                             |
| `USER`        | Specify the user name to use within the Docker container.                                      |
| `WORKDIR`     | Set the working directory within the Docker container.                                         |
| `STOPSIGNAL`  | Define the system call signal that will be sent to the container to exit.                     |
| `SHELL`       | Set the default shell to be used within the Docker container.                                  |
| `HEALTHCHECK` | Check the container's health by running a command inside the container.                       |
