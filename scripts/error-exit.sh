#!/bin/sh

PROGNAME=$(basename $0)

function error_exit {
	echo "${PROGNAME}: ${1:-"Unknown Error"}" 1>&2
	exit 1
}