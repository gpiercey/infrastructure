#!/usr/bin/env bash

DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)

function check_prerequisites() {
    REQUIRED="docker kind helm kubectl ctlptl xclip"
    for pkg in $REQUIRED; do
        [ -z "`which $pkg`" ] && echo "error: $pkg not installed" && exit 1
    done
    return 0
}

function create_cluster() {
    ctlptl apply -f "${DIR}/yaml/cluster.yaml"
    kubectl scale deployment --namespace kube-system --replicas 1 coredns
}

function delete_cluster() {
    killall kubectl
    kind delete cluster
}

function install_nginx() {
    kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
    kubectl patch -n ingress-nginx job ingress-nginx-admission-create -p '{"spec": {"ttlSecondsAfterFinished": 10}}'
    kubectl patch -n ingress-nginx job ingress-nginx-admission-patch -p '{"spec": {"ttlSecondsAfterFinished": 10}}'
    sleep 15
    kubectl wait -n ingress-nginx pods -l "app.kubernetes.io/component=controller" --for "condition=Ready" --timeout=300s
}

function install_metrics_server() {
    kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
    kubectl patch --namespace kube-system deployment metrics-server --type='json' --patch '[{"op": "replace", "path": "/spec/template/spec/containers/0/args/4", "value": "--metric-resolution=120s"}]'
    kubectl patch --namespace kube-system deployment metrics-server --type='json' --patch '[{"op": "add", "path": "/spec/template/spec/containers/0/args/-", "value": "--kubelet-insecure-tls"}]'
}

function install_dashboard() { # $1 - username
    kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.7.0/aio/deploy/recommended.yaml
    kubectl patch --namespace kubernetes-dashboard deployment kubernetes-dashboard --type='json' --patch '[{"op": "add", "path": "/spec/template/spec/containers/0/args/2", "value": "--token-ttl=0"}]'
    kubectl create --namespace kubernetes-dashboard serviceaccount $1
    kubectl create --namespace kubernetes-dashboard clusterrolebinding $1 --clusterrole cluster-admin --serviceaccount kubernetes-dashboard:$1
    sleep 10
    kubectl wait --namespace kubernetes-dashboard pods -l "k8s-app=kubernetes-dashboard" --for condition=Ready --timeout 120s
    kubectl wait --namespace kubernetes-dashboard pods -l "k8s-app=dashboard-metrics-scraper" --for condition=Ready --timeout 120s
    kubectl apply -f "${DIR}/yaml/dashboard-ingress.yaml"
}

function install_echo() {
    kubectl wait --namespace ingress-nginx pods -l "app.kubernetes.io/component=controller" --for condition=Ready --timeout 120s
    kubectl apply -f "${DIR}/yaml/echo.yaml"
}

function generate_dashboard_token() { # $1 - username
    TOKEN="$(kubectl -n kubernetes-dashboard create token $1)"
    echo
    echo "${TOKEN}" | xclip -selection clipboard
    echo "${TOKEN}"
    echo
    echo "Dashboard URL -> http://localhost"
    echo "Token for $1 -> copied to clipboard"
    echo
}
