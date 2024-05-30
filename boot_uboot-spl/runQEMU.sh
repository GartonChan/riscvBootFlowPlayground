#!/usr/bin/bash

../qemu/build/qemu-system-riscv64 -smp 2 \
    -m 2G \
    -nographic \
    -machine virt \
    -bios ../u-boot/spl/u-boot-spl.bin \
    -device loader,file=../u-boot/u-boot.itb,addr=0x80200000 \
    -blockdev driver=file,filename=./disk.img,node-name=disk \
    -device virtio-blk-device,drive=disk