#!/bin/bash

set -e

if [ -e userconfig_default.txt ]; then
    echo "Custom userconfig found, copying to target"
    cp userconfig_default.txt ${TARGET_DIR}/etc
fi
