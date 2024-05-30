#!/usr/bin/bash

../qemu/build/qemu-system-riscv64 -smp 2 \
    -m 2G \
    -nographic \
    -machine virt \
    -bios ../opensbi/build/platform/generic/firmware/fw_payload.elf \
    -blockdev driver=file,filename=./disk.img,node-name=disk \
    -device virtio-blk-device,drive=disk \
