#!/bin/bash
kubectl apply -f env-config.yaml
kubectl apply -f backend-feed.yaml
kubectl apply -f backend-user.yaml
kubectl apply -f reverseproxy.yaml
kubectl apply -f frontend.yaml