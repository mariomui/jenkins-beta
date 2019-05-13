#!/bin/bash
source "$(pwd)/helperfiles/setyaml/setYaml.sh" 

# globals
flag=true
namespace=""
namespaceCopy=""
filename=''
# end globals

#helper functions
askForInput() {
  local name
  read -e -p "Choose the Name of the Namespace or type .exit: " name
  echo $name
}

validateNamespace() {
  local name=$1
  case $name in
      *.*) echo false;;
      * )  echo true;;
  esac
}

createFile() {
  mkdir -p yaml
  echo \
"apiVersion: v1
kind: Namespace
metadata:
  name: $1" > "$(pwd)/yaml/$1-namespace.yaml"
}

createPvFile() {
  local pvName="$namespace-pv"
  mkdir -p pv 
  echo \
"apiVersion: v1
kind: PersistentVolume
metadata: 
  name: $pvName
  namespace: $namespace
spec:
  storageClassName: $pvName
  accessModes:
    - ReadWriteOnce
  capacity:
    storage: 20Gi
  persistentVolumeReclaimPolicy: Delete
  hostPath:
    path: /data/jenkins-volume" > "./pv/$pvName.yaml"
  echo "$(pwd)/pv/$pvName.yaml"
}

isEqual() {
  if (test $1 == $2)
    then
      echo true
    else 
      echo false
  fi
}
isFileHere() {
  if (test -f $1);
    then
      echo true
    else
      echo false
  fi
}

errorHandle() {
  # echo "$# is the number of arguments"
  if (test $1 == true);
    then
      echo $2
    else
      echo $3
      exit $4
  fi
}

getCurrentNs() {
  echo $(kubectl get sa default -o jsonpath='{.metadata.namespace}')
}

# /end helper functions
flag=true

while $flag; 
  #step 1-2 create the namespace and making it default
  do
    namespaceCopy=$namespace
    namespace=$(askForInput)
  if (test $namespace == .exit);
    then 
      namespace=$namespaceCopy
      break;
  fi
  if (test $namespace == "$((kubectl get ns) | (grep -o $namespace))");
    then
      echo "$namespace is already in system"
      break;
    else
      if (test $(validateNamespace $namespace) == true);
        then
          createFile $namespace
          kubectl create -f ./yaml/$namespace-namespace.yaml
          kubectl get ns
      fi
  fi
  
  #set the namespace
  kubectl config set-context $(kubectl config current-context) --namespace=$namespace  
  errorHandle $(isEqual $(getCurrentNs) $namespace) "$(getCurrentNs) has been set" "$namespace has not been set" 2
  
  #begin step3 creating the persistent volume
  filename=$(createPvFile)
  errorHandle $(isFileHere $filename) "$filename is here" "$filename isnt here" 3

  #create the persistent volume
  kubectl create -f $filename

  kubectl get pv
  
  setYaml "./values.yaml" storageClassName "$namespace-pv"
  # setYaml "../values.yaml" name "$namespace-pv"
  
  helm install --name $namespace -f ../values.yaml stable/jenkins --namespace=$namespace
  
done

printf $(kubectl get secret --namespace $namespace $namespace-jenkins -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode);echo
echo ""
export NODE_PORT=$(kubectl get --namespace $namespace -o jsonpath="{.spec.ports[0].nodePort}" services $namespace-jenkins)
export NODE_IP=$(kubectl get nodes --namespace $namespace -o jsonpath="{.items[0].status.addresses[0].address}")
echo "http://$NODE_IP:$NODE_PORT"
echo ""
echo "GET YOUR PASSWORD for username ADMIN: 
  printf \$(kubectl get secret --namespace $namespace $namespace-jenkins -o jsonpath=\"{.data.jenkins-admin-password}\" | base64 --decode);echo";
echo ""
echo "GET YOUR ACCESS POINT: 
  export NODE_PORT=\$(kubectl get --namespace $namespace -o jsonpath=\"{.spec.ports[0].nodePort}\" services $namespace-jenkins)
  export NODE_IP=\$(kubectl get nodes --namespace $namespace -o jsonpath=\"{.items[0].status.addresses[0].address}\") 
  echo \"http://\$NODE_IP:\$NODE_PORT\"";