#!/bin/bash

# Imports an App via json file using mcctl app create --datafile

err() {
    echo "ERROR: $*" >&2
	exit 2
}

usage() {
  cat << !
$0 -u URL -r REGION [-i IMAGE_PATH] json_file

  -i required if App JSON includes image_path

  Json file must be in the format

  {
    "App": {
      "key": {
        :
      },
      : App parameters
    },
    "Region": "{REGION}"
  }
!

  exit 0
}

which jq > /dev/null 2>&1 || err "This script requires 'jq'. Please install from https://stedolan.github.io/jq/"

# Check if token is valid
if [[ "$(stat -l -t %Y%m%d ~/.mctoken | cut -f6 -d' ')" != "$(date +%Y%m%d)" || "$(cat ~/.mctoken)" == "" ]]; then
  err "API token has expired. Please login with 'mcctl login'"
fi

# Script needs to know
# URL
# REGION
# Possible IMAGE_PATH

URL=""
REGION=""
IMAGE_PATH=""

while getopts u:r:i:h OPT
do
  case $OPT in
    u)  URL=$OPTARG ;;
    r)  REGION=$OPTARG ;;
    i)  IMAGE_PATH=$OPTARG ;;
    h)  usage ;;
    *)  err "Invalid option -$OPTARG" ;;
  esac
done

shift $((OPTIND -1))

[[ ! ${URL} ]] && err "URL (-u) must be specified"
[[ ! ${REGION} ]] && err "REGION (-r) must be specified"

FILE=$1

OLD_PATH=$(jq -r '.App.image_path // ""' < ${FILE})

[[ ${OLD_PATH} ]] && [[ ! ${IMAGE_PATH} ]] && err "App includes image_path=${OLD_PATH}. Please specify new path (-i)"

SUBS='.Region = "'${REGION}'"'

[[ ${IMAGE_PATH} ]] && SUBS="$SUBS"'| .App.image_path = "'${IMAGE_PATH}'"'

mcctl --addr ${URL} app create --data "$(jq "$SUBS" < $FILE)"