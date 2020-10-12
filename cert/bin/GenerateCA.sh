#!/bin/bash

if [ "$#" -ne 1 ]
then
 echo "CAName is required"
 exit 1
fi

name=$1

openssl genrsa -des3 -out ../ca/$name.key 2048
openssl req -x509 -new -nodes -key ../ca/$name.key -sha256 -days 2000 -out ../ca/$name.pem
