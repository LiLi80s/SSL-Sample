#!/bin/bash

# Directory Hierarchy.

export basedir=.
export Root_CA0_Dir=${basedir}/Root_CA_0
export Server0_Root_CA0_Dir=${Root_CA0_Dir}/Serv_0
export Client0_Root_CA0_Dir=${Root_CA0_Dir}/Cli_0
export Root_CA1_Dir=${basedir}/Root_CA_1

function cleanup {
	echo $1
	rm -fr ${Root_CA0_Dir}
}


cleanup "Clean the old folder."

[ -d ${Root_CA0_Dir} ] || mkdir -p ${Root_CA0_Dir}
[ -d ${Root_CA0_Dir}/db ] || mkdir -p ${Root_CA0_Dir}/db
[ -d ${Root_CA0_Dir}/private ] || mkdir -p ${Root_CA0_Dir}/private
[ -d ${Root_CA0_Dir}/certs ] || mkdir -p ${Root_CA0_Dir}/certs
[ -d ${Server0_Root_CA0_Dir} ] || mkdir -p ${Server0_Root_CA0_Dir}
[ -d ${Client0_Root_CA0_Dir} ] || mkdir -p ${Client0_Root_CA0_Dir}

cp RootCA.config.template ${Root_CA0_Dir}/RootCA.config


