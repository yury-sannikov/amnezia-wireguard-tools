# amnezia-wireguard-tools

An OpenWrt replacement of the wireguard-tools to enable user-space amnezia-wg protocol.

## What is this?
This package is a replacement of the OpenWrt [wireguard-tools](https://openwrt.org/packages/pkgdata/wireguard-tools) package for the [Amezia Wireguard](https://github.com/amnezia-vpn/amnezia-wg) protocol. It provides a modified [wg(8)](https://git.zx2c4.com/wireguard-tools/about/src/man/wg.8) command which is capable of handling extra Amnezia-specific arguments.

> [!CAUTION]
> Please note. This package is not compatible with the upcoming amnezia-wg kernel support.

## Prerequisites

You have to insall `amnezia-wg` first. There is no OpenWrt package for your disposal yet. You have to compile it on your own. Thanks to Go language it's pretty easy to do (well if you're handy with Go)
- Install Go
- Check out the https://github.com/amnezia-vpn/amnezia-wg
- Build it for your router platform
    - `make clean; GOOS=linux GOARCH=mipsle GOMIPS=softfloat make`
- Copy it to your router
    - `scp -O wireguard-go root@your.ip.address:/usr/bin/amnezia-wg`
- Try it on your router: `amnezia-wg wg0`

> [!TIP]
> Change `PreallocatedBuffersPerPool` to `4096` in the `amnezia-wg/device/queueconstants_default.go` to avoid nasty OOM killer.

## Installation

You have two options:
If you're lucky, you may find a ready-made artifact for your platform [here](https://github.com/yury-sannikov/amnezia-wireguard-tools/actions/runs/6975815559)

If not, you have to build it from the source code
If you're lucky, just unzip the artifact zip and copy the *.ipk file to your router then call `opkg install <file_name>.ipk`

## Building using OpenWRT SDK

Well, it seems, you fall into the unlucky category.

There are two benefits:
- you will learn how to build it from the source
- you have a chance to make a PR against this repo to include your architecture and help others

Please make yourself familiar with the https://openwrt.org/docs/guide-developer/toolchain/using_the_sdk, especially, with the `ccache` issue.

Take a look at the `amnezia-wireguard-tools/sdk_build.sh` file. You will need to change the following:
- `RELEASE` Change it from `23.05.0` to your OpenWRT router release
- `TARGET` and `SUBTARGET` should match your router
- `GCC_VERSION` should match whatever OpenWrt released

Run `sdk_build.sh` and grab some beer.
Your `.ipk` will be located under the `bin/packages/` folder
