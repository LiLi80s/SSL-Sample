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



