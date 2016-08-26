#!/usr/bin/env bash

#
# Activate an Ansible 2.0 virtualenv
#

if ! ps -o comm= -p $$ | grep -q -e 'bash$'; then
  echo "$0: only bash is supported" >&2
  exit 1
fi

if [[ ${BASH_VERSINFO[0]} -lt 3 ]]; then
  echo "$0: bash 3 or greater required" >&2
  exit 1
fi

PROGNAME=$(basename "${BASH_SOURCE[0]}")
TOPDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

usage() {
  cat <<EOF
usage: source $0
       $0 [COMMAND...]

When sourced, this script activates a virtualenv for the current shell.

Otherwise, the script runs a single command within the virtualenv.
EOF
}

#
# (Possibly build and) activate vitualenv
#
make --quiet -C ${TOPDIR} virtualenv
. ${TOPDIR}/build/virtualenv/bin/activate

#
# Ensure galaxy modules are up to date
#
make --quiet -C ${TOPDIR} galaxy

#
# Do something. Maybe.
#
if [[ "${BASH_SOURCE[0]}" != "$0" ]]; then
  # sourced script; do nothing
  :
elif [[ $# -gt 0 ]]; then
  # virtualenv command passed in
  exec "$@"
else
  usage >&2
fi
