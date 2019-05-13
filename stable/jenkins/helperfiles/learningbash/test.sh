#!/bin/bash
# sed -i "" "s/fool/mario/g" $(pwd)/jack.txt
# echo -n $(grep -o "name: [^$]*" jenkins-beta-namespace.yaml | grep -o '[^:]*$') | wc -c
# validateYaml() {
#   local var1=$1
#   local res
#   local extension=${var1##*.}
#   if (test $extension == "yaml" || test $extension == "yml") 
#   then
#     res=true
#     echo $res
#   else
#     res=false
#     echo $res
#   fi
# }
# hello=$(validateYaml $1)
# echo $hello

# askForInput() {
#   local namespaceFile
#   read -e -p "Select the namespace: " namespaceFile
#   echo $namespaceFile
# }

# echo $(askForInput)

# validateNamespace() {

# local name=$1
# case $name in
#      *.*) echo false;;
#      * )  echo true;;
# esac
# }

# validateNamespace mario123

# if (test "mario" == $(kubectl get ns | grep -o mario))
#   then
#     echo hi
# fi
# namespace=five
# createPvFile() {
#   local pvName=$namespace-pv
#   mkdir -p pv 
#   echo \
# "apiVersion: v1
# kind: PersistentVolume
# metadata: 
#   name: $pvName
#   namespace: $namespace
# spec:
#   storageClassName: $pvName
#   accessModes:
#     - ReadWriteOnce
#   capacity:
#     storage: 20Gi
#   PersistentVolumeReclaimPolicy: Delete
#   hostPath:
#     path: /data/jenkins-volume" > ./pv/$pvName.yaml
# }

# createPvFile
# verify() {
#   if (test $1 != $2);
#     then
#       echo true
#     else 
#       echo false
#   fi
# }
# getCurrentNs() {
#   echo "$(kubectl get sa default -o jsonpath='{.metadata.namespace}')"
# }

# if (test $(verify getCurrentNs namespace) == false);
#   then
#     echo what
#   else
#     echo who
# fi

# flag=true
# errorHandle() {
#   echo $#
#   if (test $1 == true);
#     then
#       echo $2
#       # break;
#     else
#       echo $3
#   fi
# }
# while $flag;
#   echo $flag;
#   do 
#     errorHandle false
# done

# getCurrentNs() {
#   echo $(kubectl get sa default -o jsonpath='{.metadata.namespace}')
# }

# getCurrentNs
# function test() {
#   [[ $- = *e* ]]; SAVED_OPT_E=$?
# }


# function teste() {
#   echo $#
# }


# errorHandle false "\"mario"\" "\"dario"\"
# echo f{alpha,beta,gamma}
# function giveMePassword() {
#   local rawPassword="$(kubectl get secrets $1 -o yaml | grep jenkins-admin-password)";
#   local decoded=${rawPassword##*:} 
#   echo $decoded | base64 --decode
#   echo
# }

# giveMePassword <service-name>
# namespace=jenkins-beta
# echo "printf (kubectl get secret --namespace $namespace $namespace) -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode);echo"

# sample="\"    \"      fsfor";

# if [[ $sample =~ \" ]];
#   then
#     echo true
#   else 
#     echo false
# fi

# echo $(pwd);
echo ($(source "./helperfiles/learningbash/if.sh"));
source "./helperfiles/learningbash/if.sh"
validate