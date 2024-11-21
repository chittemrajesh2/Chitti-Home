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
## What is Docker Compose?
Docker Compose is a tool for defining and running multi-container Docker applications. It allows you to configure multiple services, networks, and volumes in a single file, and then start all these components with a single command. The configuration is done using a YAML file, typically named docker-compose.yml.

## Use Cases of Docker Compose
**Multi-Container Applications**: When you have applications that consist of multiple services (e.g., a web server, a database, and a cache), Docker Compose allows you to manage them together.
Development Environments: Easily replicate complex environments for development purposes.

**Testing**: Set up test environments that mimic production systems.
**Deployment**: Define a consistent deployment environment for staging or production.

## Basic Components of Docker Compose

**Services**: Defines the containers that will be run. Each service can be a separate container.

**Networks**: Defines custom networks for services to communicate with each other.

**Volumes**: Defines data storage options for persisting data across container restarts.

## Example Scenario: Multi-Tier Web Application
Suppose you are developing a web application that requires a frontend web server, a backend API server, and a database. You can use Docker Compose to manage these components.
```yml
version: '3'

services:
  web:
    image: nginx:latest
    ports:
      - "80:80"
    volumes:
      - ./web:/usr/share/nginx/html
    depends_on:
      - api

  api:
    image: my-api-image
    ports:
      - "5000:5000"
    environment:
      - DATABASE_URL=postgres://db:5432/mydatabase
    depends_on:
      - db

  db:
    image: postgres:latest
    environment:
      POSTGRES_USER: exampleuser
      POSTGRES_PASSWORD: examplepassword
      POSTGRES_DB: mydatabase
    volumes:
      - db-data:/var/lib/postgresql/data

volumes:
  db-data:

```
## How to Use Docker Compose

```
docker-compose up
docker-compose down
docker-compose logs
docker-compose up --scale web=3

```
## 𝗡𝗲𝘁𝘄𝗼𝗿𝗸𝘀 𝗶𝗻 𝗗𝗼𝗰𝗸𝗲𝗿 :-
**𝑩𝒓𝒊𝒅𝒈𝒆**:-
The default networking driver in Docker. This allows containers on the same host to talk to each other. If container A and B are on the same Bridge network, they can talk to each-other.
 
But if they’re on different bridge networks, they cannot talk to each other.
When you create a new network, unless you specify a different driver, it will be a Bridge network. Docker already creates one bridge network for you when you install it. And when you run a new container on your system, by default it connects to this bridge network.
 
**𝑯𝒐𝒔𝒕** :-
The host network driver can be used to remove network isolation between the container and its host machine. Unlike in bridge, a host network Container doesn’t get its own IP address. When it binds to a port, it is directly the host port. Host mode is useful for better performance because there’s no additional network layer in between. But it only works on Linux unless you use Docker Desktop.
 
**𝑶𝒗𝒆𝒓𝒍𝒂𝒚** :-
Overlay networks allow Docker containers on different host machines to talk to each other. They connect the Docker daemons running on these hosts to each other. This allows you to scale out horizontally. You don’t have to deploy all your containers on the same server.
 
**𝑵𝒐𝒏𝒆** :-
This means your container does not have any network and it is completely isolated from the host as well as other containers. This is more secure than the other drivers since all network communication is disabled. But of course, it is only good for some use cases.
![image](https://github.com/user-attachments/assets/8c04c76f-5f02-4b7e-8b5a-7fe06664dd4c)


## CMD vs. ENTRYPOINT:

**CMD**: Sets the default command to run and can be overridden by arguments provided during container startup.

**ENTRYPOINT**: Defines the executable to run and cannot be overridden; CMD can provide default arguments to ENTRYPOINT.

## ENV vs. ARG:

**ENV**: Sets environment variables that persist into the running container.

**ARG**: Defines build-time variables that are used only during the image build process.

## COPY vs ADD 

### File Extraction:
**COPY**: Does not support extracting tar archives.
**ADD**: Automatically extracts tar archives.

### URL Handling:

**COPY**: Does not support downloading files from URLs.
**ADD**: Can fetch and add files from URLs.

### Simplicity:

**COPY**: More straightforward, used for simple file copying.
**ADD**: More feature-rich but may be overkill for simple tasks.

### Best Practices:
Prefer **COPY** for most use cases involving copying files from the build context into the Docker image. It is more explicit and easier to understand.
Use **ADD** only when you need its additional features, such as extracting archives or downloading files.
