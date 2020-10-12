#!/bin/bash

if [ "$#" -ne 2 ]
then
  echo "Usage: GenerateCASignedCert [CAName]  [domain]"
  exit 1
fi

domain=$2
caKey="../ca/$1.key"
caPem="../ca/$1.pem"
keyFile="../generated-certificates/$domain.key"
csrFile="../generated-certificates/$domain.csr"
crtFile="../generated-certificates/$domain.crt"
pfxFile="../generated-certificates/$domain.pfx"
extFile="../generated-certificates/$domain.ext"

# Don't allow the user to overwrite an existing file.
if [ -f "$keyFile" ]
then
  echo "$keyFile already exists."
  exit 1
fi

# Make sure we can locate the CAkey
if [ ! -f "$caKey" ]
then
  echo "Can't locate $caKey"
  exit 1
fi

# Make sure we can locate the CAPem
if [ ! -f "$caPem" ]
then
  echo "Can't locate $caPem"
  exit 1
fi

# Generate the key for the domain.
echo "Generate $keyFile"
openssl genrsa -des3 -out $keyFile 2048

# Generate the csr file for the domain.
echo "Generate $csrFile"
openssl req -new -key $keyFile -out $csrFile

# Generate the configuration that will be used to sign
# the certificate using the the CA in ../ca/
cat > $extFile << EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names
[alt_names]
DNS.1 = $domain
EOF

# Generate the CA signed signed 
echo "Generate $crtFile"
openssl x509 -req -in $csrFile -CA $caPem -CAkey $caKey -CAcreateserial -out $crtFile -days 1000 -sha256 -extfile $extFile

# Generate the pfx file
echo "Generate $pfxFile"
openssl pkcs12 -export -out $pfxFile -inkey $keyFile -in $crtFile

