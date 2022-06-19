#!/usr/bin/env bash

IMAGE=01e9/ide-in-docker

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";
cd "$SCRIPT_DIR"

docker build -t "${IMAGE}" . # base

for TAG in 'php-js' 'cpp' 'cpp-gpu'
do
    docker build -t "${IMAGE}:${TAG}" -f "${TAG}.Dockerfile" .
done
