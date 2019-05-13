#!/bin/bash
# first param is the servicename

helm delete --purge $1
kubectl delete pv $1-pv

helm list
kubectl get ns
kubectl get pv
kubectl get pods
kubectl get deployments
NS=default npm run jenkins:setCurrentNs
kubectl delete ns $1