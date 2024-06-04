### U-Boot
``` shell
cd ./u-boot

make qemu_riscv64_smode_defconfig

# bootcmd and bootargs
echo 'CONFIG_USE_BOOTARGS=y' >> .config
echo 'CONFIG_BOOTARGS="root=/dev/vda2 rw"' >> .config
echo 'CONFIG_USE_BOOTCOMMAND=y' >> .config
echo 'CONFIG_BOOTCOMMAND="ext4load virtio 0:1 84000000 Image; booti 0x84000000 - ${fdtcontroladdr}"' >> .config


make -j$(nproc) CROSS_COMPILE=riscv64-unknown-linux-gnu-
```

### OpenSBI
``` shell
cd ./opensbi

make PLATFORM=generic FW_PAYLOAD_PATH=../u-boot/u-boot.bin CROSS_COMPILE=riscv64-unknown-linux-gnu- -j$(nproc)
```