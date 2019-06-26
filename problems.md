# List of Issues

## DELL BIOS Update

Updating BIOS on this machine, requires you to boot into Windows and then update the firmware. I had already installed Ubuntu and did not want to reinstall Windows 10 on this machine again.

Recent versions of the DELL motherboards and BIOS allow you to simply copy the firmware to a USB stick formatted using FAT and then run BIOS update without requiring you to boot into Windows. Unfortunately our DELL OptiPLEX is ancient, more than 10 years old.

I had to create a FreeDOS bootable USB stick and copy the most recent firmware for my system. 

I followed these directions https://www.dell.com/support/article/us/en/04/sln171755/updating-the-dell-bios-in-linux-and-ubuntu-environments?lang=en 
  
Right now my BIOS is at version A22.


## MTRR Chunk Size Resolution

The Linux Kernel and the DELL BIOS fail to setup MTRR gran and chunk size that would cover all of the RAM. The system boots successfully but `dmesg` reports the following failure:

```
[  +0.000004] MTRR default type: uncachable
[  +0.000000] MTRR fixed ranges enabled:
[  +0.000001]   00000-97FFF write-back
[  +0.000001]   98000-9BFFF write-protect
[  +0.000000]   9C000-9FFFF write-back
[  +0.000001]   A0000-BFFFF uncachable
[  +0.000001]   C0000-FFFFF write-protect
[  +0.000000] MTRR variable ranges enabled:
[  +0.000001]   0 base 000000000 mask C00000000 write-back
[  +0.000001]   1 base 400000000 mask FE0000000 write-back
[  +0.000001]   2 base 420000000 mask FF0000000 write-back
[  +0.000000]   3 base 0E0000000 mask FE0000000 uncachable
[  +0.000001]   4 base 0D0000000 mask FF0000000 uncachable
[  +0.000001]   5 base 0CC000000 mask FFC000000 uncachable
[  +0.000000]   6 base 0CB000000 mask FFF000000 uncachable
[  +0.000001]   7 base 42E000000 mask FFE000000 uncachable
[  +0.000000]   8 disabled
[  +0.000001]   9 disabled
[  +0.000632] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT
[  +0.000120] total RAM covered: 16272M
[  +0.000001]  gran_size: 64M   chunk_size: 64M         num_reg: 8      lose cover RAM: 80M
[  +0.000000]  gran_size: 64M   chunk_size: 128M        num_reg: 8      lose cover RAM: 80M
[  +0.000001]  gran_size: 128M  chunk_size: 128M        num_reg: 7      lose cover RAM: 144M
[  +0.000001]  gran_size: 256M  chunk_size: 256M        num_reg: 5      lose cover RAM: 400M
[  +0.000000]  gran_size: 256M  chunk_size: 512M        num_reg: 5      lose cover RAM: 400M
[  +0.000001]  gran_size: 256M  chunk_size: 1G          num_reg: 6      lose cover RAM: 400M
[  +0.000001]  gran_size: 256M  chunk_size: 2G          num_reg: 7      lose cover RAM: 400M
[  +0.000000]  gran_size: 512M  chunk_size: 512M        num_reg: 5      lose cover RAM: 400M
[  +0.000001]  gran_size: 512M  chunk_size: 1G          num_reg: 6      lose cover RAM: 400M
[  +0.000001]  gran_size: 512M  chunk_size: 2G          num_reg: 7      lose cover RAM: 400M
[  +0.000001]  gran_size: 1G    chunk_size: 1G          num_reg: 4      lose cover RAM: 912M
[  +0.000000]  gran_size: 1G    chunk_size: 2G          num_reg: 4      lose cover RAM: 912M
[  +0.000001]  gran_size: 2G    chunk_size: 2G          num_reg: 3      lose cover RAM: 1936M
[  +0.000001] mtrr_cleanup: can not find optimal value
[  +0.000000] please specify mtrr_gran_size/mtrr_chunk_size
```

In order to fix this issue, you need to manually determine what should the `mtrr_gran_size` and `mtrr_chunk_size` from the above list, restricting to only 8 registers. I chose gran size of 64M and chunk size of 128M.

```
sudo vim /etc/default/grub

Update the GRUB_CMDLINE_LINUX_DEFAULT to the following values:
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash mtrr_gran_size=64M mtrr_chunk_size=128M hugepages=1024 iommu=pt intel_iommu=on"

Quit vim

sudo update-grub
sudo reboot now
```

Check the `dmesg` to ensure that the MTRR failures have been resolved.


## OVS make modules fails to build on Ubuntu 19.x

Erroneously I thought installing DPDK and OpenVSwitch required my Linux installation to be at Linux Kernel 5.0.0. However the ovs build for kernel modules fails to build at kernel version 5.0.0.

I needed to be at kernel version 4.18.0 and hence Ubuntu 18.04 LTS in order build the ovs kernel modules.

## Realtek 4 Port NIC is not compatible with DPDK

I blindly purchased the first 4 port NIC card for the DELL OptiPLEX, which happened to be Realtek based chipset. The Intel DPDK driver only works with a handful of chipsets and they recommend to use the Intel e1000 or e1000e driver supported chipset.

I have purchased another 4 port NIC card and I have yet to verify whether it works with DPDK plus OVS (OpenVSwitch) driver.


## OVS Modules Install Certificate Error

So now I have the correct version of Linux kernel 4.18.0, the correct version of Ubuntu 18.04, the correct version of DPDK 18.11.1, the correct version of OVS 2.11.1, and everything seems to be built correctly as per the instructions on this website http://docs.openvswitch.org/en/stable/intro/install/general/ 

The last step before loading the kernel modules is to run `make modules_install` in the OVS build tree. Everything compiles and is installed, but I get failures related to signing of the modules. There are no digital certificates.

According to various websites, I can safely ignore this error.


## DMAR Allocating domain for dcdbas failed

The step before setting DPDK using VFIO requires changes to the Linux Command Line, I had to pass the following options to the command line `iommu=pt intel_iommu=on`, run `update_grub` and reboot.

After rebooting, I find the following error messages in `dmesg` log:

```
[  +0.091110] [drm:intel_cpu_fifo_underrun_irq_handler [i915]] *ERROR* CPU pipe A FIFO underrun
[  +0.000029] [drm:intel_set_pch_fifo_underrun_reporting [i915]] *ERROR* uncleared pch fifo underrun on pch transcoder A
[  +0.000015] [drm:intel_pch_fifo_underrun_irq_handler [i915]] *ERROR* PCH transcoder A FIFO underrun
...
[  +0.000025] DMAR: Allocating domain for dcdbas failed
```

The DRM error has not yet been investigated, I am ignoring it for right now.

The DMAR error is because of a bug in the DELL motherboard setup. After turning on `intel_iommu=on`, the CMOS chipset on the motherboard fails to initialize properly. It is related to remote power control for machines. Since our machine is a desktop and it will always be monitored by us, we do not need this feature.

I am ignoring this error. There is a fix for it in the upstream Linux kernel, I am wary of upgrading to homegrown kernel for right now.


