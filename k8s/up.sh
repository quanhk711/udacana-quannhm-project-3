#!/bin/bash
kubectl apply -f aws-secret.yaml
kubectl apply -f env-configmap.yaml
kubectl apply -f env-secret.yaml

# 1/ Frontend
kubectl apply -f deployment-frontend.yaml  
kubectl apply -f service-frontend.yaml 


# 2/ feed 
kubectl apply -f deployment-api-feed.yaml   
kubectl apply -f service-api-feed.yaml       

# 3/ user
kubectl apply -f service-api-user.yaml       
kubectl apply -f deployment-api-user.yaml  

# 4/ proxy
kubectl apply -f service-reverseproxy.yaml
kubectl apply -f deployment-reverseproxy.yaml


kubectl autoscale deployment api-feed --cpu-percent=70 --min=1 --max=3
kubectl autoscale deployment backend-user --cpu-percent=70 --min=1 --max=3
kubectl autoscale deployment frontend --cpu-percent=70 --min=1 --max=3
kubectl autoscale deployment reverseproxy --cpu-percent=70 --min=1 --max=3

kubectl expose deployment frontend --type=LoadBalancer --name=publicfrontend
kubectl expose deployment reverseproxy --type=LoadBalancer --name=publicreverseproxy

kubectl get deployment
kubectl get pod
kubectl get service
kubectl get hpa
