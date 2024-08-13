# Dockerfile Scenarios and Solutions

This document provides examples of Dockerfiles for various application scenarios. Each scenario is presented with a corresponding question and answer to demonstrate how to create and optimize Dockerfiles for different use cases.

---

## 1. Simple Web Application (Python Flask)

**Question:**  
How would you create a Dockerfile for a simple Python Flask web application, ensuring it is production-ready?

**Answer:**

```Dockerfile
# Stage 1: Build the application
FROM python:3.9-slim as builder

# Set the working directory
WORKDIR /app

# Copy the requirements file
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code
COPY . .

# Stage 2: Production environment
FROM python:3.9-alpine

# Set the working directory
WORKDIR /app

# Copy the application from the builder stage
COPY --from=builder /app .

# Expose the application port
EXPOSE 5000

# Run the application
CMD ["python", "app.py"]
```
## 2. Node.js Application with Multi-Stage Build

**Question:**  
How would you create an optimized Dockerfile for a Node.js application using multi-stage builds to reduce the final image size?

**Answer:**
```
# Stage 1: Build the application
FROM node:14-alpine as builder

# Set the working directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install --production

# Copy the rest of the application code
COPY . .

# Stage 2: Production environment
FROM node:14-alpine

# Set the working directory
WORKDIR /app

# Copy the application from the builder stage
COPY --from=builder /app .

# Expose the application port
EXPOSE 3000

# Start the application
CMD ["node", "server.js"]
```
## 3. Java Spring Boot Application
**Question:**  
Can you write a Dockerfile for a Java Spring Boot application packaged as a JAR file, including any steps to minimize the image size?

**Answer:**

```Dockerfile
# Stage 1: Build the application
FROM maven:3.8.1-openjdk-11 as builder

# Set the working directory
WORKDIR /app

# Copy the pom.xml file and install dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the application source code and build the JAR file
COPY src ./src
RUN mvn package -DskipTests

# Stage 2: Production environment
FROM openjdk:11-jre-slim

# Set the working directory
WORKDIR /app

# Copy the JAR file from the builder stage
COPY --from=builder /app/target/*.jar app.jar

# Expose the application port
EXPOSE 8080

# Run the JAR file
CMD ["java", "-jar", "app.jar"]



```


## 4. PHP Application with Apache

**Question:**  
How would you create a Dockerfile for a PHP application that runs on Apache, ensuring it’s properly configured for production?

**Answer:**

```Dockerfile
# Use the official PHP image with Apache
FROM php:7.4-apache

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Set the working directory
WORKDIR /var/www/html

# Copy the application code
COPY . .

# Set the correct permissions
RUN chown -R www-data:www-data /var/www/html

# Expose the web server port
EXPOSE 80

# Start Apache in the foreground
CMD ["apache2-foreground"]


```

## 5. Python Application with Conda

**Question:**  
How can you create a Dockerfile for a Python application using Conda for dependency management?

**Answer:**

```Dockerfile
# Use a Conda base image
FROM continuumio/miniconda3

# Set the working directory
WORKDIR /app

# Copy the environment.yml file and create the environment
COPY environment.yml .
RUN conda env create -f environment.yml

# Activate the environment
SHELL ["conda", "run", "-n", "myenv", "/bin/bash", "-c"]

# Copy the application code
COPY . .

# Expose the application port
EXPOSE 5000

# Run the application
CMD ["conda", "run", "--no-capture-output", "-n", "myenv", "python", "app.py"]

```

## 6. Nginx as a Reverse Proxy

**Question:**  
How would you set up Nginx as a reverse proxy for another service using a Dockerfile?



**Answer:**

```Dockerfile
# Use the official Nginx image
FROM nginx:alpine

# Copy custom Nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Expose the HTTP and HTTPS ports
EXPOSE 80 443

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]

```
