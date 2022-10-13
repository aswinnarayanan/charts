#!/bin/bash

sudo snap install microk8s --classic
microk8s enable community
microk8s enable dns fluentd ingress metrics-server prometheus rbac registry storage

helm repo add ais https://australian-imaging-service.github.io/charts
helm repo update

kubectl delete namespaces cert-manager
kubectl delete namespaces ctp
kubectl create namespace ctp

# helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
# helm repo update
# helm install ingress-nginx ingress-nginx/ingress-nginx
