#!/bin/bash

set -e

# Call mkknlimg to install the Device Tree
"${HOST_DIR}/usr/bin/mkknlimg" "${BINARIES_DIR}/zImage" "${BINARIES_DIR}/zImage-dt"
mv "${BINARIES_DIR}/zImage-dt" "${BINARIES_DIR}/zImage"

echo "Installing config.txt"
cp $(dirname $0)/config_aroio.txt ${BINARIES_DIR}/config.txt

EXPORTDIR=${BINARIES_DIR}/sdcard
DISTDIR=$(dirname $0)/dist_aroio

echo "Generating SD card content in ${EXPORTDIR}"


mkdir -p ${EXPORTDIR}
cp -r ${BINARIES_DIR}/rpi-firmware/* ${EXPORTDIR}/ || echo "Error ignored"
cp ${BINARIES_DIR}/*.dtb ${EXPORTDIR}/
cp ${BINARIES_DIR}/zImage ${EXPORTDIR}/
cp ${BINARIES_DIR}/config.txt ${EXPORTDIR}/
cp -r ${DISTDIR}/* ${EXPORTDIR}/

#rm -f ${EXPORTDIR}/cmdline.txt

if [ -e userconfig_default.txt ]; then
    echo "Found a default userconfig, using this"
    cp userconfig_default.txt ${EXPORTDIR}/userconfig.txt
fi

BOARD_DIR="$(dirname $0)"
BOARD_NAME="$(basename ${BOARD_DIR})"
GENIMAGE_CFG="${BOARD_DIR}/genimage-aroio.cfg"
GENIMAGE_TMP="${BUILD_DIR}/genimage.tmp"

# Mark the kernel as DT-enabled
mkdir -p "${BINARIES_DIR}/kernel-marked"
${HOST_DIR}/usr/bin/mkknlimg "${BINARIES_DIR}/zImage" \
	"${BINARIES_DIR}/kernel-marked/zImage"

rm -rf "${GENIMAGE_TMP}"

genimage                           \
	--rootpath "${TARGET_DIR}"     \
	--tmppath "${GENIMAGE_TMP}"    \
	--inputpath "${BINARIES_DIR}"  \
	--outputpath "${BINARIES_DIR}" \
	--config "${GENIMAGE_CFG}"


echo ">>DONE"

exit $?
