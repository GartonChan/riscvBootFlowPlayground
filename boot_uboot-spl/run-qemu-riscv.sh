#!/usr/bin/bash

qemu-system-riscv64 -smp 2 \
    -m 2G \
    -nographic \
    -machine virt \
    -bios ./u-boot/spl/u-boot-spl.bin \
    -device loader,file=./u-boot/u-boot.itb,addr=0x80200000 \
    -blockdev driver=file,filename=./disk.img,node-name=disk \
    -device virtio-blk-device,drive=disk \
    -device virtio-net-device,netdev=net0\
    -netdev user,id=net0,net=192.168.42.0/24,hostfwd=tcp:127.0.0.1:5555-:22\
    -dtb qemu.dtb \
