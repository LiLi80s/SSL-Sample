#!/bin/bash

function exit_with_failure {
	reason=$1;
	echo ${reason};
	exit 1;
}

function exit_with_succeed {
	info=$1;
	echo ${info};
	exit 0;
}

#Prepare folder structure and needed environment variables.

export base_dir=.
export ca0_dir=${base_dir}/ca0
export subca0_dir=${ca0_dir}/subca0
export client_subca0_dir=${subca0_dir}/client
export server_subca0_dir=${subca0_dir}/server
export ca0_config=${base_dir}/ca0.conf
export subca0_config=${base_dir}/subca0.conf
 
function cleanup {
    echo $1
    rm -fr ${ca0_dir}
}
 
cleanup "Clean the old folder."
 
[ -d ${ca0_dir} ]			|| mkdir -p ${ca0_dir}
[ -d ${ca0_dir}/db ]		|| mkdir -p ${ca0_dir}/db
[ -d ${ca0_dir}/private ]	|| mkdir -p ${ca0_dir}/private
[ -d ${ca0_dir}/certs ]		|| mkdir -p ${ca0_dir}/certs
[ -d ${subca0_dir} ]		|| mkdir -p ${subca0_dir}
[ -d ${client_subca0_dir} ]	|| mkdir -p ${client_subca0_dir}
[ -d ${server_subca0_dir} ]	|| mkdir -p ${server_subca0_dir}

chmod 700 ${ca0_dir}/private
touch ${ca0_dir}/db/index
openssl rand -hex 16 > ${ca0_dir}/db/serial
echo 1001 > ${ca0_dir}/db/crlnumber


#Generate Private Key for this CA.

ca0_key_path=${ca0_dir}/private/${ca0_dir}.key
#openssl genrsa -aes256  -passout pass:Welcome  -out ${ca0_key_path} 2048

#[ $? == 0 ] || exit_with_failure "Generate Private Key failed."

[ -f ${ca0_config} ] || exit_with_failure "No Root CA configure file ${ca0_config}."
openssl req -new -config ${ca0_config} -out ${ca0_dir}/ca0.csr -keyout ${ca0_key_path} -passout pass:Welcome
[ $? == 0 ] || exit_with_failure "Generate CSR failed."
openssl ca -selfsign -config ${ca0_config} -in ${ca0_dir}/ca0.csr -out  ${ca0_dir}/ca0.crt -extensions ca_ext
