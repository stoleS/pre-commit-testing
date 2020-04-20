#!/bin/bash

PROGNAME=$(basename $0)

error_exit()
{
	echo "${PROGNAME}: ERROR: ${1:-"Unknown Error"}" 1>&2
	exit 1
}