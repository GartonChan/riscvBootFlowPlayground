### OpenSBI
``` shell
cd ./opensbi
make PLATFORM=generic CROSS_COMPILE=riscv64-linux-gnu- FW_TEXT_START=0x80000000 FW_OPTIONS=0 -j$(nproc)
```

### U-Boot
``` shell
cd ./u-boot

make qemu-riscv64_spl_defconfig

# bootcmd and bootargs
#todo

make OPENSBI=../opensbi/build/platform/generic/firmware/fw_dynamic.bin CROSS_COMPILE=riscv64-linux-gnu- -j$(nproc)
```
