# Potato 2 - Final Project: Kubernetes
Senior Design Final Project: Kubernetes on Spot instances


#### Tools/technology being used
- Kubernetes
- Rancher
- Docker
- AWS
- Git
- MEAN Stack 

#### Current Status of Project
Docker-compose is being setup so I can see if everything runs correctly using our Frontend and Backend.

After setting up Docker compose I'll be running each Docker file on it's own to create different containers for each service.

I will then call those containers using Kubectl to be part of my Cluster that I'm running in Minikube.

The pod should then be running the containers needed for the MEAN stack and with a proper configuration file should communicate with each other. The diagram gives an idea of what that should look like.


#### How to Execute Code
At the top directory the current code runs with:
```
docker-compose build
```
** The Frontend and Backend directories rely on the files found here: https://github.com/CSUN-Irrigation/software-irrigation



#### FAQ - Potential or known issues related to the setup or execution of code


#### Diagram of MEAN Stack Kubernetes Cluster
![Image of Kubernetes Cluster](https://imgur.com/1e8zpgd.png)
