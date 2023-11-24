#!/bin/bash

RELEASE="23.05.0"
TARGET="ramips"
SUBTARGET="mt7621"
GCC_VERSION="12.3.0"


SDK_FILE_NAME=openwrt-sdk-${RELEASE}-${TARGET}-${SUBTARGET}_gcc-${GCC_VERSION}_musl.Linux-x86_64
rm -rf sdk || true
wget https://downloads.openwrt.org/releases/${RELEASE}/targets/${TARGET}/${SUBTARGET}/${SDK_FILE_NAME}.tar.xz
tar -xf ${SDK_FILE_NAME}.tar.xz
mv ${SDK_FILE_NAME} sdk
rm ${SDK_FILE_NAME}.tar.xz
cd sdk
echo "src-git awgtools https://github.com/yury-sannikov/amnezia-wireguard-tools.git" >> ./feeds.conf.default
./scripts/feeds update awgtools
./scripts/feeds install -a -p awgtools
./scripts/feeds install amnezia-wg-tools
make defconfig
make package/amnezia-wg-tools/{download,prepare,configure,compile}
