## FAQ

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
### Question #2
- These are the causes of this issue:
    1. This happens
    
    #### Answer
    - This is fixed by doing the following:
        1. By doing this

#
### Question #3
- These are the causes of this issue:
    1. This happens

    #### Answer
    - This is fixed by doing the following:
        1. By doing this
