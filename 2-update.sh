#!/bin/bash

helm upgrade ctp ./releases/ctp --install --values ./my-ctp-site-overrides.yaml --namespace ctp

# pub_ip=$(microk8s kubectl get node --output jsonpath='{.items[0].status.addresses[?(@.type == "InternalIP")].address}')
# microk8s kubectl -n ctp patch svc ctp-httpsimport -p '{"spec":{"externalIPs":["'${pub_ip}'"]}}'

# kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.9.1/cert-manager.crds.yaml

helm repo add jetstack https://charts.jetstack.io
helm repo update
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.9.1 \
  --set installCRDs=true

# kubectl create -n ctp -f issuer-prod.yaml
# kubectl create -n ctp -f ingress-prod.yaml


# kubectl create -n ctp -f issuer-staging.yaml
# kubectl create -n ctp -f ingress-staging.yaml

kubectl create -n ctp -f issuer-prod.yaml
kubectl create -n ctp -f ingress-prod.yaml

## Edit the ho
# microk8s.kubectl edit -n ingress daemonset.apps/nginx-ingress-microk8s-controller
          # ports:
          #   - name: http
          #     hostPort: 80
          #     containerPort: 80
          #     protocol: TCP
          #   - name: https
          #     hostPort: 7777
          #     containerPort: 443
          #     protocol: TCP
          #   - name: health
          #     hostPort: 10254
          #     containerPort: 10254
          #     protocol: TCP
