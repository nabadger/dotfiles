#!/bin/sh
KUBECTL_VERSION=1.17.0
KUSTOMIZE_VERSION=3.2.1
K3D_VERSION=1.3.4

mkdir -p ${HOME}/bin

curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl && mv kubectl $HOME/bin && chmod +x $HOME/bin/kubectl
curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64 &&  chmod +x skaffold && mv skaffold $HOME/bin
curl -Lo k3d https://github.com/rancher/k3d/releases/download/v${K3D_VERSION}/k3d-linux-amd64 && chmod +x k3d && mv k3d $HOME/bin

export GO111MODULE=on
go get sigs.k8s.io/kustomize/kustomize/v3@v${KUSTOMIZE_VERSION}
go get github.com/mintel/k8s-yaml-splitter  
