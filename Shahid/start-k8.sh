#!/bin/bash
SET KOPS_CLUSTER_NAME=potato2.k8s.local
SET KOPS_STATE_STORE=s3://potato2-kops-state-store
kops create cluster --node-count=2 --node-size=t2.medium --zones=us-east-1a
kops update cluster --name potato2.k8s.local --yes
sleep 5m
kops validate cluster
kubectl get nodes
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml
kubectl cluster-info
kubectl apply -f mysql-pv.yaml
kubectl apply -f mysql-deployment.yaml
kubectl apply -f nginx-svc.yaml
kubectl apply -f nginx-deployment.yaml
kubectl expose deployment nginx-deployment --port 80 --type=LoadBalancer
kops get secrets admin --type secret -oplaintext
kubectl proxy