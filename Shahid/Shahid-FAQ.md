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
        1. Chown the entire .minikube directory.
        ```
        sudo chown -R $(id -u):$(id -g) *
        ```
        2. Chown the entier .kube directory.
        ```

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
         