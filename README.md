# Cloud Developer Nanodegree

This code is intended as Project 3.

## Image Build

All the components of the project have Dockerfiles to build them, and you can trigger the build going to ./course-03/exercises/udacity-c3-deployment/project_3_solution and then running:

```
docker-compose build
```

The base images used are from my [Docker Hub](https://hub.docker.com/). The image on the screenshots folder states the public nature of each image.
To run the project with containers outside the K8S cluster just run>

```
docker-compose up
```

The UI is available on port 8100 and both backends are available on 8080.

## Local Setup Prerequisites

To run the demo locally, you need to install minikube. The instructions on how to install it are [here](https://kubernetes.io/docs/tasks/tools/install-minikube/),
but basically what you need to do is to download the minikube cluster and install it on your system:

```
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube
sudo mkdir -p /usr/local/bin
sudo install minikube /usr/local/bin
```

Start minikube with more memory and CPUs, if possible:

```
minikube --memory 8192 --cpus 2 start
```

Besides that, to run it you need a virtualization driver. In our case we used Virtualbox, so download and run the installer for your specific platform [here](https://www.virtualbox.org/wiki/Downloads).
Finally, we will interact with our cluster using kubectl, so it is also a requirement.
We also download and install the binary, like the minikube part:

```
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x kubectl
sudo install kubectl /usr/local/bin
```

## Cloud Setup Prerequisites

To setup the cluster on the cloud we use KubeOne, so we need to download the binary from [here](https://github.com/kubermatic/kubeone/releases).
To create the cluster we used the instructions from [here](https://github.com/kubermatic/kubeone/blob/master/docs/quickstart-aws.md).
To run the scripts you have to install terraform or provide the required infrastructure on AWS. We chose the first, so we downloaded terraform from [here](https://www.terraform.io/downloads.html), cloned the kubeone repo and performed:

```
cd examples/terraform/aws/
terraform init
```

We created the terraform.tfvars like the one provided in the "project_3_solution", so copy it if you want to replicate this setup.

## Cluster Setup

You can just run local_setup.sh and it should prepare you kubernetes cluster. This script does the following:

* Creates secrets and ConfigMaps, required to set up our services, using the "project_3_solution/env-config.yaml" file
* Creates the User service backend using the "project_3_solution/backend-user.yaml" file.
* Creates the Feed service backend using the "project_3_solution/backend-feed.yaml" file.
* Creates the reverse proxy for our services using "project_3_solution/reverseproxy.yaml" file.
* Creates the frontend service (provider) using "project_3_solution/frontend.yaml" file.

Excluding the ConfigMap and Secrets, everything needed to run the services was grouped in each file, so the Deployment and Service for each microservice are inside the respective yaml.

To enable localhost conectivity to the deployed app, we need to forward our ports to the deployed infrastructure. Run the following in a terminal to export the reverse proxy:

```
kubectl port-forward svc/reverseproxy 8080:8080
```

In another terminal forward the frontend port:

```
kubectl port-forward svc/frontend 8100:8100
```

With this we'll have the UI on port 8100 and the backends on port 8080, just like the version without K8S.
