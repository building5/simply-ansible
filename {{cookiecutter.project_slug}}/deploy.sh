#!/usr/bin/env bash

#
# Deploy script
#

PROGNAME="$(basename "$0")"
cd "$(dirname "$0")"

if test $? -ne 0; then
  echo "${PROGNAME}: could not cd to $(dirname $0)" >&2
  exit 1
fi

usage() {
    cat <<EOF
usage: $0 [OPTION]... -- [extra options for ansible-playbook]
EOF
}

help() {
    usage
    cat <<EOF
Options:
  --env ENV             Environment to deploy
                        Defaults to vagrant
  --initial             Prepare new instances for deploy
                        Implies --really-reboot
  --really-reboot       If scripts detect a reboot is required, reboot
EOF
}

: "${ENV:=vagrant}"
: "${EXTRA:=}"

while test $# -gt 0; do
  case $1 in
    # split --flag=arg
    --*=*)
      flag=${1/=*/}
      arg=${1/*=/}
      shift 1
      set -- ${flag} ${arg} "$@"
      ;;
    --env)
      ENV=$2
      shift 2
      ;;
    --really-reboot)
      EXTRA="-e really_reboot=True"
      shift 1
      ;;
    --initial|--init)
      #
      # New instances only have the `vagrant` user, so we'll have to deploy
      # using that. And intial deployments are the best time to reboot.
      #
      EXTRA="--user vagrant ${EXTRA} -e really_reboot=True --tags initial"
      shift 1
      ;;
    --help)
      help
      exit 0
      ;;
    --)
      shift 1
      break
      ;;
    *)
      echo "${PROGNAME}: Unknown option $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

set -- ${EXTRA} "$@"

source activate.sh

set -ex
exec ansible-playbook \
  -v \
  --diff \
  --inventory-file ./inventory/${ENV}.ini \
  "$@" \
  -- site.yml
