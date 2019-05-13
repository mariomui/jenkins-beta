function getAccessPoint() {
  local namespace=$1
  export NODE_PORT=$(kubectl get --namespace $namespace -o jsonpath="{.spec.ports[0].nodePort}" services $namespace-jenkins)
  export NODE_IP=$(kubectl get nodes --namespace $namespace -o jsonpath="{.items[0].status.addresses[0].address}")
  echo "http://$NODE_IP:$NODE_PORT"
}

if (test $(baseName $0) == "getAccessPoint.sh");
  then
    getAccessPoint "$@"
fi