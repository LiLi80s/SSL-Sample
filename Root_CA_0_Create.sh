#!/bin/bash


function exit_with_failure {
	echo $1;
	exit 1;
}

# Generate PrivateKey and CSR.
if [ ! ${Root_CA0_Dir} ] ; then
	exit_with_failure "Environment not set, please go to Env_Setup.sh to specify one."
fi

CA_Config=${Root_CA0_Dir}/RootCA.config

if [ -d ${Root_CA0_Dir} ]; then
	openssl genrsa -aes128 -out ${Root_CA0_Dir}/RootCA.key 2048
else
	exit_with_failure "No RootCA folder found, exit.";
fi

if [ -f ${CA_Config} ] ; then
	openssl req -new -config ${CA_Config} -out ${Root_CA0_Dir}/RootCA.csr -key ${Root_CA0_Dir}/RootCA.key
else
	echo "No RootCA.config file."
	exit 1
fi
[ $? == 0 ] || exit $?

if [ -f ${Root_CA0_Dir}/RootCA.csr ] ; then
	openssl ca -selfsign -config ${CA_Config} -in ${Root_CA0_Dir}/RootCA.csr -out ${Root_CA0_Dir}/RootCA.crt -extensions ca_ext
else
	echo "No RootCA.csr file."
	exit 1
fi

[ $? == 0 ] || exit $?
exit 0
