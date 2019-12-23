#!/bin/sh
KUBECTL_VERSION=1.17.0
KUSTOMIZE_VERSION=3.2.1

mkdir -p ${HOME}/bin

curl -LO https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl && mv kubectl $HOME/bin && chmod +x $HOME/bin/kubectl

curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64 &&  chmod +x skaffold && mv skaffold $HOME/bin

GO111MODULE=on go get sigs.k8s.io/kustomize/kustomize/v3@v${KUSTOMIZE_VERSION}
