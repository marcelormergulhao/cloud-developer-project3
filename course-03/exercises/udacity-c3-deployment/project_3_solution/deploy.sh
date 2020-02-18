#!/bin/bash
export WORKDIR=$PWD/course-03/exercises/udacity-c3-deployment/project_3_solution
export KUBECONFIG=$WORKDIR/k8scluster-kubeconfig
kubectl apply -f $WORKDIR/env-config.yaml
kubectl apply -f $WORKDIR/backend-feed.yaml
kubectl apply -f $WORKDIR/backend-user.yaml
kubectl apply -f $WORKDIR/frontend.yaml
kubectl apply -f $WORKDIR/reverseproxy.yaml
