#!/bin/bash

PROGNAME=$(basename $0)

error_exit()
{
	echo "[ERROR]: ${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
	exit 1
}

echo_info()
{
	echo "[INFO]: ${1}"
}