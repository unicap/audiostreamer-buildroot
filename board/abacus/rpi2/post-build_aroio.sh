#!/bin/bash

set -e

if [ -e userconfig_default.txt ]; then
    echo "Custom userconfig found, copying to target"
    cp userconfig_default.txt ${TARGET_DIR}/etc
fi

echo -n $(git log --format="Commit: %h from %aD" -n 1) > ${TARGET_DIR}/VERSION
echo -n $(git log --format="%ct" -n 1) > ${TARGET_DIR}/VERSION_TIMESTAMP

