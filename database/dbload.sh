#!/usr/bin/env bash

progname="$(basename $0)"
# XXX

[ -z "${FRONTISTIRIO_BASEDIR}" ] && {
	echo "${progname}: FRONTISTIRIO_BASEDIR: not set" >&2
	exit 2
}

usage() {
	echo "usage: ${progname}" >&2
	exit 1
}

errs=

while getopts ":" opt
do
	case "${opt}" in
	?)
		echo "${progname}: -$OPTARG; invalid option" >&2
		errs=1
		;;
	esac
done

[ -n "${errs}" ] && usage

shift $(expr $OPTIND - 1)
[ $# -gt 0 ] && usage

datadir="${FRONTISTIRIO_BASEDIR}/local/sample_data"
cd "${datadir}" 2>/dev/null || {
	echo "${progname}: ${datadir}: direcotry not found" >&2
	exit 4
}

mysql -u root -p frontistirio <"${FRONTISTIRIO_BASEDIR}/database/dbload.sql"
