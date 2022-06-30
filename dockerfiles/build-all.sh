#!/usr/bin/env bash

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";
cd "$SCRIPT_DIR"

IMAGE=01e9/ide-in-docker
PUSH=${PUSH:-}

docker build -t "${IMAGE}" . # base
[ -n "$PUSH" ] && docker push "${IMAGE}"

for TAG in 'php-js' 'cpp' 'cpp-gpu'
do
    docker build -t "${IMAGE}:${TAG}" -f "${TAG}.Dockerfile" .
    [ -n "$PUSH" ] && docker push "${IMAGE}:${TAG}"
done
