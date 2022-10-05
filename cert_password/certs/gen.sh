#!/usr/bin/env bash
set -euo pipefail

# usage: ./gen.sh

reqarg=""
################################################################################
# Setup CA
################################################################################
mkdir -p ./demoCA/newcerts
rm -f demoCA/index.txt
touch demoCA/index.txt
echo "01" > demoCA/serial

prefix="ca"
openssl genrsa ${reqarg}  -out ${prefix}-key.pem
openssl req -new -key ${prefix}-key.pem -out ${prefix}-csr.pem \
	-config <(echo "
		[ req ]
		prompt = no
		distinguished_name = req_distinguished_name
		string_mask = utf8only
		utf8 = yes
		x509_extensions	= v3_ca
		[ req_distinguished_name ]
		C = US
		ST = CA
		L = San Francisco
		O = Synadia
		OU = nats.io
		CN = localhost ca
		[ v3_ca ]
		subjectKeyIdentifier=hash
		authorityKeyIdentifier=keyid:always,issuer
		basicConstraints = critical,CA:true
	")
openssl ca -batch -keyfile ${prefix}-key.pem -selfsign -notext \
	-config <(echo "
		[ ca ]
		default_ca = ca_default
		[ ca_default ]
		dir = ./demoCA
		database = ./demoCA/index.txt
		new_certs_dir = ./demoCA/newcerts
		serial = ./demoCA/serial
		default_md = default
		policy = policy_anything
		x509_extensions	= v3_ca
		default_md = sha256
		default_enddate = 20291014135726Z
		copy_extensions = copy
		[ policy_anything ]
		countryName = optional
		stateOrProvinceName = optional
		localityName = optional
		organizationName = optional
		organizationalUnitName = optional
		commonName = supplied
		emailAddress = optional
		[ v3_ca ]
		subjectKeyIdentifier=hash
		authorityKeyIdentifier=keyid:always,issuer
		basicConstraints = critical,CA:true
	") \
	-out ${prefix}-cert.pem -infiles ${prefix}-csr.pem

################################################################################
# Client cert
################################################################################
prefix="client"
openssl genrsa ${reqarg} -out ${prefix}-key.pem 
openssl req -new -key ${prefix}-key.pem -out ${prefix}-csr.pem \
	-config <(echo "
		[ req ]
		prompt = no
		distinguished_name = req_distinguished_name
		req_extensions = v3_req
		string_mask = utf8only
		utf8 = yes
		[ req_distinguished_name ]
		C = US
		ST = CA
		L = San Francisco
		O = Synadia
		OU = nats.io
		CN = localhost client
		[ v3_req ]
		subjectAltName = @alt_names
		[ alt_names ]
		IP.1 = 127.0.0.1
		IP.2 = 0:0:0:0:0:0:0:1
		DNS.1 = localhost
		DNS.2 = client.localhost
	")
openssl ca -batch -keyfile ca-key.pem -cert ca-cert.pem -notext \
	-config <(echo "
		[ ca ]
		default_ca = ca_default
		[ ca_default ]
		dir = ./demoCA
		database = ./demoCA/index.txt
		new_certs_dir = ./demoCA/newcerts
		serial = ./demoCA/serial
		default_md = default
		policy = policy_anything
		x509_extensions	= ext_ca
		default_md = sha256
		default_enddate = 20291014135726Z
		copy_extensions = copy
		[ policy_anything ]
		countryName = optional
		stateOrProvinceName = optional
		localityName = optional
		organizationName = optional
		organizationalUnitName = optional
		commonName = supplied
		emailAddress = optional
		[ ext_ca ]
		basicConstraints = CA:FALSE
		keyUsage = nonRepudiation, digitalSignature, keyEncipherment
		extendedKeyUsage = serverAuth, clientAuth
	") \
	-out ${prefix}-cert.pem -infiles ${prefix}-csr.pem

################################################################################
# Server cert
################################################################################
prefix="server"
openssl genrsa -des3 ${reqarg} -out ${prefix}-key.pem
openssl req -new -key ${prefix}-key.pem -out ${prefix}-csr.pem \
	-config <(echo "
		[ req ]
		prompt = no
		distinguished_name = req_distinguished_name
		req_extensions = v3_req
		string_mask = utf8only
		utf8 = yes
		[ req_distinguished_name ]
		C = US
		ST = CA
		L = San Francisco
		O = Synadia
		OU = nats.io
		CN = localhost server
		[ v3_req ]
		subjectAltName = @alt_names
		[ alt_names ]
		IP.1 = 127.0.0.1
		IP.2 = 0:0:0:0:0:0:0:1
		DNS.1 = localhost
		DNS.2 = server.localhost
	")
openssl ca -batch -keyfile ca-key.pem -cert ca-cert.pem -notext \
	-config <(echo "
		[ ca ]
		default_ca = ca_default
		[ ca_default ]
		dir = ./demoCA
		database = ./demoCA/index.txt
		new_certs_dir = ./demoCA/newcerts
		serial = ./demoCA/serial
		default_md = default
		policy = policy_anything
		x509_extensions	= ext_ca
		default_md = sha256
		default_enddate = 20291014135726Z
		copy_extensions = copy
		[ policy_anything ]
		countryName = optional
		stateOrProvinceName = optional
		localityName = optional
		organizationName = optional
		organizationalUnitName = optional
		commonName = supplied
		emailAddress = optional
		[ ext_ca ]
		basicConstraints = CA:FALSE
		keyUsage = nonRepudiation, digitalSignature, keyEncipherment
		extendedKeyUsage = serverAuth, clientAuth
	") \
	-out ${prefix}-cert.pem -infiles ${prefix}-csr.pem

################################################################################
# Clean up
################################################################################
rm -f *-csr.pem
rm -rf ./demoCA

## Check Key
openssl pkey -in server-key.pem 

