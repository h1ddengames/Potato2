## FAQ

### Important Note:
A lot of issues can be avoided just by having your host machine be a *nix operating system. In order words: try not to use Windows if at all possible.

### Question #1: minikube start command states "Unable to start VM"
- These are the causes of this issue:
    You might be trying to start minikube in a local VM:

    1. This is due to virtualbox not being installed on the machine. 

    2. VT-X/AMD-v is not enabled to allow nested VMs.

    #    
    #### Answer
    
    - This is fixed by doing the following:
        1. Install virtualbox by running the following command:
        ```
        sudo apt-get install virtualbox
        ```
        2. If you are running the VM in vmware then click on VM > Settings > Processors > Check Virtualize Intel VT-x/EPT or AMD-V/RVI then restart the VM.

#
### Question #2: kubectl get nodes command states "The connection to the server localhost:8080 was refused"
- These are the causes of this issue:
    1. This happens because minikube has not finished creating the VM. 
    
    #### Answer
    - This is fixed by doing the following:
        1. Just wait until minikube has finished. 
        2. In the meantime check that the kubectl config is present and correct:
            1.  Run the following command to both check for and display the contents of the kube config file: 
            ```
            sudo cat ~/.kube/config
            ```
#
### Question #3: minikube gets stuck on "Waiting for pods: apiserver"
- These are the causes of this issue:
    1. This happens for because minikube has not finished creating the VM.

    #### Answer
    - This is fixed by doing the following:
        1. Just wait until minikube has finished.

#
### Question #4: minikube dashboard states "failed to open browser: exit status 3"
- These are the causes of this issue:
    1. This happens because you might have run the following command with sudo:
        ```
        sudo minikube dashboard
        ```

    #### Answer
    - This is fixed by doing the following:
        1. Don't run the command using sudo.

#
### Question #5: minikube dashboard states "Error getting machine status: load: filestore: open ~/.minikube/machines/minikube/config.json: permission denied"
- These are the causes of this issue:
    1. This happens because you don't have permission to use that file.

    #### Answer
    - This is fixed by doing the following:
        1. Change directory into the .minikube directory then chown the entire directory.
        ```
        sudo chown -R $(id -u):$(id -g) *
        ```
        2. Change directory into the .kube directory then chown the entire directory.
        ```
        sudo chown -R $(id -u):$(id -g) *
        ```

#
### Question #6: minikube dashboard states "kube-system:kubernetes-dashboard is not running: Temporary Error: Error getting service kubernetes-dashboard"
- These are the causes of this issue:
    1. This happens when minikube was not configured properly due to a permission issue. Make sure you follow step 0 in the documentation.

    #### Answer
    - This is fixed by doing the following:
        1. Run the following command:
        ```
        minikube delete
        ```
        then continue following the documentation from the beginning.
         
#
### Question #7: running kops create cluster states "SSH public key must be specified when running with AWS"
- These are the causes of this issue:
    1. This happens because kops requires a SSH public key.

    #### Answer
    - This is fixed by doing the following:
        1. Create the public key:
            ```
            kops create secret --name potato2.k8s.local sshpublickey admin -i C:\Users\yourusername/.ssh/id_rsa.pub
            ```

#
### Question #8: running kops create secret states "error adding SSH public key: error fingerprinting SSH public key"
- These are the causes of this issue:
    1. This happens because you need to have a .ssh folder.

    #### Answer
    - This is fixed by doing the following:
        1. Run the following command to create the .ssh folder with a id_rsa public and private key:
            ```
            ssh-keygen
            ```
        2. Use all the default options and take note of where the key was saved to. Usually: 
            ```
            C:\Users\yourusername/.ssh/id_rsa.pub
            ```

#
### Question #9 running kops get secret sates "State Store: Required value: Please set the --state flag or export KOPS_STATE_STORE."
- These are the causes of this issue:
    1. This happens because the value of KOPS_STATE_STORE was not properly set.

    #### Answer
    - This is fixed by doing the following:
        1. Run the following command:
            ```
            SET KOPS_STATE_STORE=s3://potato2-kops-state-store
            ```

#
### Question #10 Logging into the kubernetes dashboard gives me errors saying "configmaps is forbidden: User cannot list..."
- These are the causes of this issue:
    1. This happens because the user you logged in as does not have the permissions to view the metrics listed.

    #### Answer
    - This is fixed by doing the following:
        1. make sure you are listing the admin key: ie. the username is after secrets keyword below
        ```
        kops get secrets admin --type secret -oplaintext
        ```

#
### Question #11 How do I access the website on the cluster?

#### Answer
- This is done by doing the following:
    1. Log onto the dashboard and click on Services then click on the service you want to access.
    2. Click on the ip address under External endpoints.

    OR

    3. Run the following command:
        ```
        kubectl get svc
        ```
    
    Note: No matter which option you take, you'll have to make sure there's an external ip.

#
### Question #12 Why do I not have an external IP on my deployment/service?
- These are the causes of this issue:
    1. This happens because you haven't exposed the port/ip.

    #### Answer
    - This is fixed by doing the following:
        1. Run the following command:
            ```
            kubectl expose deployment nginx-deployment --port 80 --type=LoadBalancer
            ```
        2. List all the services with the following command:
            ```
            kubectl get services -o wide
            ```

#
### Question #13 I keep getting "server IP address could not be found" when trying to access the website hosted by the cluster.
- These are the causes of this issue:
    1. This happens when you are running the wrong command or looking at the wrong area on the dashboard.

    #### Answer
    - This is fixed by doing the following:
        1. See Questions 11 and 12 for the answer.

#
### Question #14
- These are the causes of this issue:
    1. This happens

    #### Answer
    - This is fixed by doing the following:
        1. By doing this


#
### Question #15
- These are the causes of this issue:
    1. This happens

    #### Answer
    - This is fixed by doing the following:
        1. By doing this