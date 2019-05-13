#!/bin/bash
# @param <service-name>
function jenkinsPasswordGetter() {
  local rawPassword="$(kubectl get secrets --namespace=$1 $1-jenkins -o yaml | grep jenkins-admin-password)";
  local decoded=${rawPassword##*:}
  echo $decoded | base64 --decode
  echo
}

if (test $(baseName $0) == "jenkinsPasswordGetter.sh");
  then
    jenkinsPasswordGetter "$@"
fi