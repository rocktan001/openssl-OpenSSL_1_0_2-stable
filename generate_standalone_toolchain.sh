#!/bin/bash
# set -x
###################################################################
## 交叉编译NDK 目录，必填
ANDROID_NDK_HOME=/media/disk2/tools/android-ndk-r10e
## android API ,必填
API=21
####################################################################

export PATH=$ANDROID_NDK_HOME:$PATH
  
TOOLCHAIN=$PWD/android-toolchain-arm

if [ ! -d "$TOOLCHAIN" ]
then
    mkdir -p $TOOLCHAIN

    NDK=$(dirname $(which ndk-build))
    $NDK/build/tools/make-standalone-toolchain.sh \
        --platform=android-$API \
        --arch=arm \
        --install-dir=$TOOLCHAIN
fi

CROSS_COMPILE=$TOOLCHAIN/bin/arm-linux-androideabi-
# export CROSS_COMPILE
export PATH=$TOOLCHAIN/bin:$PATH
export AR=${CROSS_COMPILE}ar
export CC=${CROSS_COMPILE}gcc
export CXX=${CROSS_COMPILE}g++
export LD=${CROSS_COMPILE}gcc
export RANLIB=${CROSS_COMPILE}ranlib
export NM="${CROSS_COMPILE}nm"
export STRIP="${CROSS_COMPILE}strip"
export PLATFORM=android
export CFLAGS="-D__ANDROID_API__=$API -DANDROID -fPIC -pie"
#export LDFLAGS="-fPIE -pie"

#./Configure android-armv7 -D__ANDROID_API__=21
