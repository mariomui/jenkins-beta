#!/bin/bash
# params (inputfile, value, key)
function setYaml() {
  local extension=""
  local basicName=""
  local newLine=""
  local lineNo=1
  local num=0
  local tempYaml="/var/tmp/temporaryYaml.yaml"
  local flag="false";
  $(echo -n "") > $tempYaml

  IFS=
  while read -r line; 
    do
      # echo $line
      # noSpaceLine=$(echo $line | xargs);
      # echo "$noSpaceLine!!!!!!!"
        #  if [[ $line =~ ^[" "]{0,100}"persistence" ]];
        #   then
        #     echo "i was here"
        #     echo $lineno
        #     flag=true
        #   fi
        #   if [[ $line =~ ^[" "]{0,100}"networkPolicy" ]];
        #     then
        #       flag=false
        #   fi
      if [[ ( $line =~ ^[" "]{0,100}"$2:" ) || ( $line =~ ^" "{0,100}"- $2:" ) ]];
        then 
          extension=${line#*:}
          basicName=${line%:*}
       
            
          if [[ $extension =~ \" ]];
            then
              newLine="$basicName: \"$3\""
            else
              newLine="$basicName: $3"
          fi
          echo $newLine >> $tempYaml
          # newLine=$(echo ": \"$3\"") >> sample.txt
          echo "$line has changed to $newLine on line $lineNo" | xargs 
          num=$((num+1))
        else 
          echo $line >> $tempYaml
      fi
      lineNo=$(( lineNo + 1 ))
  done < "./$1"
  echo "$num lines have been edited"
  echo "$(cat $1 | wc -l) lines in total"
  cp $tempYaml "./$1"
}

currentSource="$(baseName $0)";
if (test $currentSource == "setYaml.sh");
  then
    setYaml "$@"
fi
