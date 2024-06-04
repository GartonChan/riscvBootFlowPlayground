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
echo 'CONFIG_USE_BOOTARGS=y' >> .config
echo 'CONFIG_BOOTARGS="root=/dev/vda2 rw"' >> .config
echo 'CONFIG_USE_BOOTCOMMAND=y' >> .config
echo 'CONFIG_BOOTCOMMAND="ext4load virtio 0:1 84000000 Image; booti 0x84000000 - ${fdtcontroladdr}"' >> .config


make OPENSBI=../opensbi/build/platform/generic/firmware/fw_dynamic.bin CROSS_COMPILE=riscv64-linux-gnu- -j$(nproc)
```
