## Setting up Kubernetes on a Virtual Machine

#### Install VirtualBox or VMWare
1. Run the following command:
    ```
    sudo apt-get install virtualbox
    ```

2. Make sure that Intel VT-x/EPT or AMD-V/RVI is enabled.


#### Install Kubectl
1. Run the following commands:
    ```
    sudo apt-get update && sudo apt-get install -y apt-transport-https
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
    sudo apt-get update
    sudo apt-get install -y kubectl
    ```

#### Install Minikube
1. Run the following commands:
    ```
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    sudo install minikube-linux-amd64 /usr/local/bin/minikube
    ```

2. Make sure Intel VT-x/EPT or AMD-V/RVI is enabled.

#### Install Docker
1. Run the following command:
    ```
    sudo apt-get install docker
    ```


#### Run Minikube
1. Run this command to start Minikube
    ```
    minikube start
    ```

2. Run these commands to check that the cluster is running:
    ```
    kubectl get nodes
    kubectl cluster-info
    ```

3. Start the minikube dashbaord:
    ```
    minikube dashboard
    ```