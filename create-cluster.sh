#!/bin/bash

kind create cluster --config multi-node.yaml --name homelab-core

kubectl cluster-info --context kind-homelab-core

#metalLB
kubectl apply -f https://raw.githubusercontent.com/google/metallb/v0.9.3/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/google/metallb/v0.9.3/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

kubectl apply -f metalLB/metallb-def.yaml

