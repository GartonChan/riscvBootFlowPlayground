### U-Boot
``` shell
cd ./u-boot

make qemu_riscv64_smode_defconfig

# bootcmd and bootargs
#todo

make -j$(nproc CROSS_COMPILE=riscv64-unknown-linux-gnu-
```

### OpenSBI
``` shell
cd ./opensbi

make PLATFORM=generic FW_PAYLOAD_PATH=../u-boot/u-boot.bin CROSS_COMPILE=riscv64-unknown-linux-gnu- -j$(nproc)
```