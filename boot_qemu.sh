##########################################################
# File Name		: qemu_boot.sh
# Author		: wqshao
# Created Time	: 2018年03月22日 星期四 17时42分04秒
# Description	:
##########################################################
#!/bin/bash
PWD=$('pwd')

#QEMU_PATH="$PWD/mips-qemu/bin/"
QEMU_PATH="$PWD/qemu/qemu-mips/bin/"

rootfs="$PWD/rootfs/rootfs.cpio.gz"
kernel="$PWD/kernel/vmlinux"
#kernel="$PWD/for-x2000-qemu/vmlinux-x2000-qemu"

QEMU=qemu-system-mipsel

echo "
-----------------------------
- update x1000 $1 rootfs
----------------------------
"
$QEMU_PATH/${QEMU} \
	-machine perseus -cpu xburst2-x2000 \
	-kernel ${kernel} \
	-append "console=ttyS0,115200n8 rdinit=/linuxrc root=/dev/ram0 rw mem=256M@0x0 mem=768M@0x30000000" \
	-initrd ${rootfs} \
	-serial /dev/tty \
	-nographic \
	-net nic,model=rtl8139 \
	-net user,hostfwd=tcp::2029-:22,hostfwd=tcp::2087-:80
					#定义的ssh端口号         #定义的http的端口号                        

