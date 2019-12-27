#!/bin/sh
KUBECTL_VERSION=1.17.0
KUSTOMIZE_VERSION=3.2.1
K3D_VERSION=1.3.4
STERN_VERSION=1.11.0
CONFTEST_VERSION=0.15.0

mkdir -p ${HOME}/bin

curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl && mv kubectl $HOME/bin && chmod +x $HOME/bin/kubectl
curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/latest/skaffold-linux-amd64 &&  chmod +x skaffold && mv skaffold $HOME/bin
curl -Lo k3d https://github.com/rancher/k3d/releases/download/v${K3D_VERSION}/k3d-linux-amd64 && chmod +x k3d && mv k3d $HOME/bin
curl -Lo stern https://github.com/wercker/stern/releases/download/{$STERN_VERSION}/stern_linux_amd64 && chmod +x stern && mv stern $HOME/bin
curl -Lo /tmp/conftest.tar.gz https://github.com/instrumenta/conftest/releases/download/v${CONFTEST_VERSION}/conftest_${CONFTEST_VERSION}_Linux_x86_64.tar.gz && tar zxvf /tmp/conftest.tar.gz && chmod +x conftest && mv conftest $HOME/bin

export GO111MODULE=on
go get sigs.k8s.io/kustomize/kustomize/v3@v${KUSTOMIZE_VERSION}
go get github.com/mintel/k8s-yaml-splitter
go get github.com/warrensbox/tgswitch
go get github.com/warrensbox/terraform-switcher
go get github.com/prometheus/prometheus/cmd/promtool
go get github.com/prometheus/alertmanager/cmd/amtool
go get github.com/brancz/gojsontoyaml
