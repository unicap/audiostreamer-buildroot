#!/bin/bash

set -e

# Call mkknlimg to install the Device Tree
"${HOST_DIR}/usr/bin/mkknlimg" "${BINARIES_DIR}/zImage" "${BINARIES_DIR}/zImage-dt"
mv "${BINARIES_DIR}/zImage-dt" "${BINARIES_DIR}/zImage"
