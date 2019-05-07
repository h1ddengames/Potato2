## Setting up Kubernetes on a Virtual Machine
#

#### Install VirtualBox or VMWare
1. Run the following command:
    ```
    sudo apt-get install virtualbox
    ```

2. Make sure that Intel VT-x/EPT or AMD-V/RVI is enabled.

#
#### Install Kubectl
1. Run the following commands:
    ```
    sudo apt-get update && sudo apt-get install -y apt-transport-https curl
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
    echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
    sudo apt-get update
    sudo apt-get install -y kubectl
    ```

#
#### Install Docker
1. Run the following command:
    ```
    sudo apt-get install docker
    ```

#
#### Install Minikube
1. Run the following commands:
    ```
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    sudo install minikube-linux-amd64 /usr/local/bin/minikube
    ```

2. Make sure Intel VT-x/EPT or AMD-V/RVI is enabled.

#
#### Run Minikube
0. Run the following commands:
    ```
    sudo chown -R $(id -u):$(id -g) ~/.minikube/*

    sudo chown -R $(id -u):$(id -g) ~/.kube/*
    ```

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

4. Visit your minikube dashboard:
http://127.0.0.1:34191/api/v1/namespaces/kube-system/services/http:kubernetes-dashboard:/proxy/#!/cluster?namespace=default


#
## Setting up Kubernetes on a AWS using Windows 10
#

#### Installing the requirements
1. Download and install AWS CLI: https://aws.amazon.com/cli/
2. Download and move kubectl: https://kubernetes.io/docs/tasks/tools/install-kubectl/ 
then move it to the directory C:\Kube
3. Download kops: https://github.com/kubernetes/kops, then rename the download to kops.exe. Finally move the file to C:\Kube
4. Add AWS CLI, kubectl, and kops to path:
    1. Press the windows key then type in ```env```
    2. Select the option that says ```Edit the system environment variables```
    3. Click on ```Environment Variables```
    4. Under ```System Variables```, double click ```Path```.
    5. Select new and add ```C:\Program Files\Amazon\AWSCLI\bin```
    6. Select new and add ```C:\Kube```
5. Restart your computer.

#
#### Setting up the Kubernetes Cluster
1. Run the following command in order to create a S3 bucket for kops to use. 
    ```
    aws s3api create-bucket --bucket potato2-kops-state-store --region us-east-1
    ```
2. Enable versioning on the newly created bucket:
    ```
    aws s3api put-bucket-versioning --bucket potato2-kops-state-store  --versioning-configuration Status=Enabled
    ```
3. Set environment varaibles for kops to use:
    ```
    SET KOPS_CLUSTER_NAME=potato2.k8s.local
    SET KOPS_STATE_STORE=s3://potato2-kops-state-store
    ```

    Note: in order to print out these variables in your CLI, run the following command:
        ```
        echo %KOPS_CLUSTER_NAME%
        echo %KOPS_STATE_STORE%
        ```

4. Create a public key for kops
    ```
    ssh-keygen

    kops create secret --name potato2.k8s.local sshpublickey admin -i C:\Users\yourusername/.ssh/id_rsa.pub
    ```

    Note: run ssh-keygen and select all the default options. It should save your private and public keys to C:\Users\yourusername/.ssh/id_rsa

5. Generate the cluster configuration. Creates the configuration and writes to the s3 bucket:
    ```
    kops create cluster --node-count=2 --node-size=t2.medium --zones=us-east-1a 
    ```

    Note: a lot of information will be displayed after this step. 

6. Build the cluster:
    ```
    kops update cluster --name potato2.k8s.local --yes
    ```

7. Before running this step, WAIT a couple minutes or you WILL get errors. It takes time to launch the nodes. You can check the progress of the build by logging into your AWS Console then going to EC2 and making sure you're in the same region that you listed in step 5.
    ```
    kops validate cluster
    ```

8. Check that the nodes are running:
    ```
    kubectl get nodes
    ```

#
#### Setting up the Kubernetes Dashboard
1. Run the following to start the dashboard
    ```
    kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml
    ```

2. Get the AWS Hostname:
    ```
    kubectl cluster-info
    ```

3. Visit your dashboard using the command above or use the following command to create a proxy:
    ```
    kubectl proxy
    ```

    Then visit the url: http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/

    Note: if you use the AWS Hostname the username will be admin and the password can be found with the following command:

    ```
    kops get secrets admin --type secret -oplaintext
    ```

4. When logging into the dashboard using the proxy method, it will ask you to enter a token. Obtain this token using this command:
    ```
    kops get secrets admin --type secret -oplaintext
    ```

#
#### Creating a service and/or deployment file using yaml
1. Create an nginx deployment file called run-my-nginx.yaml and put in the following:
    ```
    apiVersion: apps/v1
    kind: Deployment
    metadata:
        name: my-nginx
    spec:
        selector:
            matchLabels:
                run: my-nginx
        replicas: 2
        template:
            metadata:
                labels:
                    run: my-nginx
            spec:
                containers:
                - name: my-nginx
                image: nginx
                ports:
                - containerPort: 80
    ```
2. Create a mysql persistent volume file called mysql-pv.yaml and put in the following:
    ```
    kind: PersistentVolume
    apiVersion: v1
    metadata:
        name: mysql-pv-volume
        labels:
            type: local
    spec:
        storageClassName: manual
        capacity:
            storage: 20Gi
        accessModes:
            - ReadWriteOnce
        hostPath:
            path: "/mnt/data"
    ---
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
        name: mysql-pv-claim
    spec:
        storageClassName: manual
        accessModes:
            - ReadWriteOnce
        resources:
            requests:
                storage: 20Gi
    ```
3. Create a mysql deploymennt file called mysql-deployment.yaml and put in the following:
    ```
    apiVersion: v1
    kind: Service
    metadata:
        name: mysql
    spec:
        ports:
        - port: 3306
        selector:
            app: mysql
        clusterIP: None
    ---
    apiVersion: apps/v1 # for versions before 1.9.0 use apps/v1beta2
    kind: Deployment
    metadata:
        name: mysql
    spec:
        selector:
            matchLabels:
                app: mysql
        strategy:
            type: Recreate
        template:
            metadata:
            labels:
                app: mysql
        spec:
            containers:
            - image: mysql:5.6
                name: mysql
                env:
                # Use secret in real usage
            - name: MYSQL_ROOT_PASSWORD
                value: password
            ports:
            - containerPort: 3306
                name: mysql
            volumeMounts:
            - name: mysql-persistent-storage
                mountPath: /var/lib/mysql
            volumes:
            - name: mysql-persistent-storage
            persistentVolumeClaim:
                claimName: mysql-pv-claim
    ```
#
#### Using the dashboard to deploy an application and/or service


#
#### Destroy a cluster
1. Run the following command to destroy the cluster
    ```
    kops delete cluster --name potato2.k8s.local --yes
    ```