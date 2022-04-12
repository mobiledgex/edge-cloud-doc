#!/bin/bash

# Exports App data in a format that can be re-used with mcctl app create --datafile

err() {
    echo "ERROR: $*" >&2
	exit 2
}

which jq > /dev/null 2>&1 || err "This script requires 'jq'. Please install from https://stedolan.github.io/jq/"

# Check if token is valid
if [[ "$(stat -l -t %Y%m%d ~/.mctoken | cut -f6 -d' ')" != "$(date +%Y%m%d)" || "$(cat ~/.mctoken)" == "" ]]; then
  err "API token has expired. Please login with 'mcctl login'"
fi

URL=https://console.mobiledgex.net

DEV=${1}

if [[ ! $DEV ]]; then
  err "Usage: $0 developer [directory]"
fi

mcctl --addr ${URL} --output-format json org show name=${DEV} | grep -q '"Type": "developer"' || err "${DEV} is not a Developer"

DIR=${2}

if [[ ! ${DIR} ]]; then
  DIR="."
fi

OUT_DIR=${DIR}/${DEV}

mkdir -p ${OUT_DIR} || err "Unable to create output directory ${OUT_DIR}"

echo Exporting App data for ${DEV} to ${OUT_DIR}
read -p "Enter to continue of CTRL+C to quit: " FOO

for REGION in EU US JP
do
  # Generate App List
  mcctl --addr ${URL} --output-format json app show region=${REGION} app-org=${DEV} | jq -r '.[] | [.key.name, .key.version ] | join(" ")' | \
  while read APP_NAME APP_VERSION
  do
    echo -n "Exporting ${REGION} - ${APP_NAME} vers=${APP_VERSION} . . . "
    mcctl --addr ${URL} --output-format json app show region=${REGION} app-org=${DEV} appname=${APP_NAME} appvers=${APP_VERSION} | \
      jq '.[] | del(.created_at, .updated_at) | {"App": . } + {"Region":"'${REGION}'"}' > ${OUT_DIR}/app_${REGION}_${DEV}_${APP_NAME}_${APP_VERSION}.json
    echo "done"
    done
done

echo Export successful

ls -l ${OUT_DIR}