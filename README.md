# RISC-V Bootflow in QEMU Playground

As a beginner in RISC-V, In this repo, I am learning the bootflow of RISC-V, and want to emulate it with QEMU.

NOTE: different from [Direct Boot](https://qemu-project.gitlab.io/qemu/system/linuxboot.html), in which to launch a kernel on QEMU without having to make a full bootable image and just passing a parameter `-kernel` to specify the kernel image. Then `qemu-system-riscv64` will load it automatically. (This is helpful for kernel debugging, but hides many details of the bootflow)

## In this playground.
As it has variant bootflows, here I just focus on two of them:

1. I boot it by using a payload firmware of OpenSBI.

    `./boot_payload`: BootROM -> FSBL -> FW_Payload -> UBoot -> Linux Kernel 

2. I change it to use a dynamic firmware of OpenSBI.

    `./boot_uboot-spl`: BootROM -> UBoot-SPL -> FW_Dynamic + Uboot-Proper -> Linux Kernel

## Jargon
1. `PBL`: Primary Boot Loader
2. `SPL`: Secondary Program Loader
3. `ZSBL`: Zero Stage Boot Loader
4. `FSBL`: First Stage Boot Loader
5. `SSBL`: Second Stage Boot Loader


## Bootflow Summary
#### Stage 0. ZSBL
BootROM (PBL)

- Processor boots from BootROM
- Copies FSBL from memory device to SRAM and start executing FSBL.

#### Stage 1. FSBL
Specific FSBL / U-Boot-SPL

- Copies next stage of code into DRAM
- Further initialization 
- Launches SSBL

#### Stage 2. SSBL
OpenSBI + UBoot-Proper

- OpenSBI: FW_Payload / FW_Dynamic / FW_Jump
- Flexibilities in boot sources.

#### (Stage 3. Kernel + RootFS)

## Several ways to boot linux in RISC-V
```
(a) BootROM -> Specific FSBL -> OpenSBI -> Linux
(b) BootROM -> Specific FSBL -> OpenSBI -> U-Boot-Proper -> Linux
(c) BootROM -> U-Boot-SPL -> OpenSBI -> U-Boot-Proper -> Linux
```

For a), usually FPGA platforms use this approach.

For b) and c), mostly real world SoC tend to use these flows. We have bootloaders which provide `advance booting methods`. We can load kernel image from SD card OR Flash OR TFTP without changing firmware or bootloader.

The c) approach is most flexible because we can `upgrade` any image in the boot flow without changing other images.

## Reference
1. [RISC-V Summit_bootflow](https://riscv.org/wp-content/uploads/2019/12/Summit_bootflow.pdf)
2. [Software Boot and PL Configuration (Xilinx)](https://xilinx.eetrend.com/files-eetrend-xilinx/forum/201509/9245-20465-13_software_boot_and_pl_configuration.pdf)
3. [RISC-V Bringup Unmatched](https://github.com/carlosedp/riscv-bringup/blob/master/unmatched/Readme.md#build-opensbi)
4. [Which is the easiest way to boot linux with opensbi](https://github.com/riscv-software-src/opensbi/issues/180)
5. [RISC-V CPU加电执行流程](https://www.cnblogs.com/mkh2000/p/15811708.html)
6. [u-boot SPL启动流程](https://wowothink.com/1e031f74/)
7. [Don't let a lack of hardware stop you from messing with new hardware.](https://colatkinson.site/linux/riscv/2021/01/27/riscv-qemu/) 
8. [Running U-Boot & Linux Kernel in QEMU](https://www.codingame.com/playgrounds/84444/running-u-boot-linux-kernel-in-qemu/prologue)
