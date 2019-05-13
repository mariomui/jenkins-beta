validate() {
  local res=true
  echo $res
}

if (test -f $(pwd)/if.sh && test $(validate) == true)
then
  echo oo
else
  echo boo
fi

if (test $(baseName $0) == "if.sh");
  then 
     validate "$@"
fi