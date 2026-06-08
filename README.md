# Vora Docker Image

This repository contains the `Dockerfile` for the **Vora** project. It packages an Ubuntu-based Apache 2 web server. 

The HTML template used for this project is the **Vora** template from Tooplate. You can download the original template here: [2161_vora_bold.zip](https://www.tooplate.com/zip-templates/2161_vora_bold.zip).

# DcokerHub image Repository 

Docker hub image repository link: https://hub.docker.com/repository/docker/hurairahhh/voraimg

Pull the image of the project by command "docker push hurairahhh/voraimg:tagname"

## Features

- **Base Image:** `ubuntu:latest`
- **Web Server:** Apache 2
- **Tools Included:** Git
- **Exposed Port:** 80
- **Volume:** `/var/log/apache2` (for persisting Apache logs)
- **Working Directory:** `/var/www/html`
- **Content:** Automatically extracts `vora.tar.gz` into the web root `/var/www/html`.

## Prerequisites

Before building the image, ensure you have the `vora.tar.gz` archive in the same directory as the `Dockerfile`. *(Note: If you download the template zip from Tooplate, you'll need to extract it and repackage the contents into a tarball named `vora.tar.gz` so the Docker build's `ADD` command works automatically)*.

## Building the Image

To build the Docker image locally, run the following command in the directory containing the `Dockerfile`:

```bash
docker build -t vora-app .
```

## Running the Container

Once the image is built, you can start a container using:

```bash
docker run -d -p 80:80 -v vora-logs:/var/log/apache2 --name vora-server vora-app
```

You can then access the web server by navigating to `http://localhost` in your web browser.

## Deploying on AWS EC2

Here is the recommended process for building and running this Docker image on an AWS EC2 instance:

1. **Launch an EC2 Instance:** 
   - Choose an **Ubuntu Server** AMI.
   - Configure the Security Group to allow inbound **HTTP (port 80)** and **SSH (port 22)** traffic.

2. **Connect to your EC2 Instance:**
   ```bash
   ssh -i /path/to/your-key.pem ubuntu@<your-ec2-public-ip>
   ```

3. **Install Docker:**
   ```bash
   sudo apt update
   sudo apt install docker.io unzip -y
   sudo systemctl enable --now docker
   sudo usermod -aG docker ubuntu
   newgrp docker
   ```

4. **Clone the Repository & Prepare the Template:**
   ```bash
   git clone <your-github-repo-url>
   cd Dockerfiles
   
   # Download the Tooplate template
   wget https://www.tooplate.com/zip-templates/2161_vora_bold.zip
   unzip 2161_vora_bold.zip
   
   # Create the vora.tar.gz archive required by the Dockerfile
   tar -czvf vora.tar.gz -C 2161_vora_bold .
   ```

5. **Build and Run the Container:**
   ```bash
   docker build -t vora-app .
   docker run -d -p 80:80 --name vora-server vora-app
   ```

6. **View the Website:**
   Open your web browser and navigate to the public IP address or Public IPv4 DNS of your EC2 instance (e.g., `http://<your-ec2-public-ip>`).

## Author

- hurairah
