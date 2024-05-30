### Build QEMU to emulate 64-bit RISC-V Architecture
``` shell
cd qemu

git checkout stable-8.2
git submodule init
git submodule update --init --recursive

./configure --target-list=riscv64-softmmu
make -j$(nproc)

# make install  # This will install to /usr
```

### Compile a linux kernel
``` shell
cd linux 

git checkout v6.7 

make defconfig ARCH=riscv
make -j$(nproc) ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu-
```



### Build a Root File System (with busybox)
``` shell
cd busybox

git checkout 1_36_stable

make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- defconfig

# make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- CONFIG_PREFIX=/path/to/RFS  install

make ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- install
```
**NOTE:** RFS is in `./_install` without specified `CONFIG_PREFIX=/path/to/RFS`

Actually, we can also change to other distros.


### Make an Image
use `mkImage.sh` to make an bootable image with the linux kernel and the busybox rootFS.

### Boot Process
More details are in these two subdirectories:
- `boot_payload`
    - README.md
- `boot_uboot-spl`
    - README.md
