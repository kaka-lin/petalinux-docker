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

Run docker image

```sh
$ chmod +x run.sh # only need run once
$ ./run.sh
```

Create a PetaLinux project:

```sh
$ petalinux -t project -s <path to the xilinx BSP file>
```

In <PetaLinux-project>, build the Linux image:

```sh
$ petalinux-build
```

more detail pleaser see: [Zynq UltraScale+ MPSoC: Embedded Design Tutorial](https://docs.xilinx.com/v/u/2020.1-English/ug1209-embedded-design-tutorial)

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
