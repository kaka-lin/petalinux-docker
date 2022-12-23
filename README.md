# PetaLinux Docker

A Dockerfile for building Xilinx PetaLinux using Ubuntu.

## Prepare installer

The PetaLinux installer needs to be downloaded from the [Xilinx's Embedded Design Tools website](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/embedded-design-tools.html). It needs to be prepared for unattended installation.

Download the installer and save it into `data/` folder.

- [petalinux-v2020.2-final-installer.run](https://www.xilinx.com/member/forms/download/xef.html?filename=petalinux-v2020.2-final-installer.run)

> Other version: petalinux-vXXX.X-final-installer.run

## Build

1. Download 

```bash
# change the access permissions of files (only need do once)
$ chmod +x build.sh

$ ./build.sh
```

## Usage

For more PetaLinux usage detail please see: [Zynq UltraScale+ MPSoC: Embedded Design Tutorial](https://docs.xilinx.com/v/u/2020.1-English/ug1209-embedded-design-tutorial)

#### 1. Run docker image

```sh
$ chmod +x run.sh # only need run once
$ ./run.sh
```

#### 2. Create a PetaLinux project:

Using the command as below for creating a PetaLinux project

```bash
$ petalinux-create -t project -s <path to the xilinx BSP file>
```

#### 3. Config project

Using the command as below for config your setting

```bash
$ petalinux-config
```

#### 4. Build the Linux Image

Using the command as below for building the `linux image`

```bash
$ petalinux-build
```

#### 5. Generate the Boot Image

Using the command as below for generating the `boot image`

```bash
$ petalinux-package --boot --fsbl zynqmp_fsbl.elf --u-boot
```

```bash
$ petalinux-package --boot --fsbl zynqmp_fsbl.elf \
    --fpga system.bit \
    --pmufw pmufw.elf \
    --atf bl31.elf \
    --u-boot u-boot.elf
```
   - `--pmufw`: <PMUFW_ELF>
   - `--atf`: <ATF_ELF>
   - `--fpga`: added bitstream. (Have PL side design)

> Refer `$ petalinux-package --boot --help` for more detail.

This creates a `BOOT.BIN` image file in the following directory

```
<petalinux-project>/images/linux/BOOT.BIN
```

#### 6. Deploy to the Board

Please copy BOOT.BIN, image.ub and boot.scr files to the SD card.

## Issues

1. `ERROR: Failed to Extract Yocto SDK.`

    ```sh
    [INFO] Extracting yocto SDK to components/yocto
    ERROR: Failed to Extract Yocto SDK.
    ERROR: Failed to config project.
    ```

    Solution: install `cpio`

    ```sh
    $ sudo apt update && sudo apt install cpio
    ```

## Reference

- [z4yx/petalinux-docker](https://github.com/z4yx/petalinux-docker)
- [carlesfernandez/docker-petalinux](https://github.com/carlesfernandez/docker-petalinux)
- [Zynq UltraScale+ MPSoC: Embedded Design Tutorial](https://docs.xilinx.com/v/u/2020.1-English/ug1209-embedded-design-tutorial)
