#!/bin/bash
# prep release for upload to production container

set -e

# make ipxe directory to store ipxe disks
mkdir -p build/ipxe

# pull down upstream iPXE
git clone --depth 1 https://github.com/ipxe/ipxe.git ipxe_build

# copy iPXE config overrides into source tree
cp ipxe/local/* ipxe_build/src/config/local/

# copy certs into source tree
#cp script/*.crt ipxe_build/src/

# build iPXE disks
cd ipxe_build/src

# get current iPXE hash
IPXE_HASH=`git log -n 1 --pretty=format:"%H"`

# generate netboot.xyz iPXE disks
make bin/ipxe.dsk bin/ipxe.iso bin/ipxe.lkrn bin/ipxe.usb bin/ipxe.kpxe bin/undionly.kpxe \
EMBED=../../ipxe/disks/netboot.xyz 

mv bin/ipxe.dsk ../../build/ipxe/netboot.xyz.dsk
mv bin/ipxe.iso ../../build/ipxe/netboot.xyz.iso
mv bin/ipxe.lkrn ../../build/ipxe/netboot.xyz.lkrn
mv bin/ipxe.usb ../../build/ipxe/netboot.xyz.usb
mv bin/ipxe.kpxe ../../build/ipxe/imfia.kpxe
mv bin/undionly.kpxe ../../build/ipxe/netboot.xyz-undionly.kpxe

