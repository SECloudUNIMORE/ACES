#!/bin/sh -
# rootfs_extractor.sh - extract the rootfs given a flash dump file
# Usage: dd_extractor.sh <flash_dump_file>
# Dependencies: python3, radare2, unsquashfs, cpio

DUMP_FILE=$1

: '
From the boot log:
0x000000000000-0x000000010000 : "bootstrap"
0x000000010000-0x000000020000 : "uboot-env"
0x000000020000-0x000000050000 : "uboot"
0x000000050000-0x000000350000 : "kernel"
0x000000350000-0x0000003d0000 : "data"
0x0000003d0000-0x000000800000 : "app"
'

mkdir -p parts/rootfs
mkdir parts/tmp

dd if="$DUMP_FILE" of=parts/bootstrap.dd count=128
dd if="$DUMP_FILE" of=parts/uboot-env.dd count=128 skip=128
dd if="$DUMP_FILE" of=parts/uboot.dd count=384 skip=256
dd if="$DUMP_FILE" of=parts/kernel.dd count=6144 skip=640
dd if="$DUMP_FILE" of=parts/data.dd count=1024 skip=6784
dd if="$DUMP_FILE" of=parts/app.dd count=8576 skip=7808

cd parts || exit

gzip_magic="1f8b08"
target="kernel.dd"
offset=$(rafind2 -x $gzip_magic $target | head -1)

dd if=$target bs=1 skip="$offset" | gunzip >tmp/out
target="tmp/out"
offset=$(rafind2 -x $gzip_magic $target | head -1)
dd if=$target bs=1 skip="$offset" | gunzip >tmp/rootfs.cpio

python3 -m venv tmp/venv
source tmp/venv/bin/activate
pip3 install jefferson

unsquashfs -d rootfs/app app.dd

rmdir rootfs/app/userdata
jefferson data.dd -d rootfs/app/userdata
cd rootfs && cpio -id <../tmp/rootfs.cpio
rm -rf ../tmp