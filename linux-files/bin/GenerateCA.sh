!#/bin/sh

if [ "$#" -ne 1 ]
then
	echo "Domain is required"
	exit 1
fi

domain=$1

openssl genrsa -out ../ca/$DOMAIN.key 2048
openssl req -new -key ../ca/$domain.key out ../ca/$domain.csr
