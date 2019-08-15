---
layout: page
title: Linux Command Line
permalink: /cmdline/
---

The OpenvSwitch and DPDK requires us to use IOMMMU (IO Memory Management Unit) to access the PCI cards instead of using DMA (Direct Memory Access).

IOMMU uses the Intel VT-d instruction set to provide access to the PCI devices.

Additionally we have to use HugePages TLB (Translate Lookaside Buffer) which keeps a map of how the virtual memory addresses are mapped to actual physical addresses. The virtual address space is 48 bits out of the total of 64 bits. The virtual address space is much larger than physical or actual address space which is restricted to the amount of physical RAM installed in the system. TLB keeps track of the virtual to physical map using pages.

The Intel DPDK library uses IOMMU and `/dev/hugepages` to operate the physical ports of the Intel NIC (Network Interface Card).

## Enable IOMMU in BIOS Setting

The system BIOS, the system motherboard, and the CPU should be able to handle IOMMU. If you have a very old system or your BIOS is not updated, then IOMMU is most likely not available on your system.

To check, reboot the system, press F2 or F12 to boot into your BIOS setting and then enable VT-d (IOMMU is enabled when VT-d is enabled). 

Some of the systems have UEFI Secure boot process and this would also restrict what you can do with the BIOS settings. Most of the ATMs (Bank Teller Machines), Android phones and other kiosk like systems have secure UEFI boot process. If your BIOS is UEFI Secure, then you need to consult your system manual to figure out how to turn it off or find out if VT-d is enabled.

## Enable IOMMU in Linux Command Line

In addition to the BIOS setting, you also need to pass in command line options to your Linux boot loader.

On most Ubuntu systems, the boot loader is `grub`. As is the case with Linux, there are many boot loaders. We will assume you are using `grub`.

{% highlight bash %}

# Check the current Linux Command Line Options
cat /proc/cmdline

# Edit the Command Line options, I am using vim editor, you can use any other editor
sudo vim /etc/default/grub

# Update the GRUB_CMDLINE_LINUX_DEFAULT to the following values:
GRUB_CMDLINE_LINUX_DEFAULT="quiet splash hugepages=1024 iommu=pt intel_iommu=on"

# If you are on AMD based system, substitute intel_iommu with amd_iommu

# Update grub
sudo update-grub
sudo reboot now

# Check the updated command line

cat /proc/cmdline

# Here is the output
BOOT_IMAGE=/boot/vmlinuz-4.18.0-24-generic root=UUID=c46c6b92-5ff7-48ca-8efc-3d3917e32a1c ro quiet splash hugepages=1024 iommu=pt intel_iommu=on vt.handoff=1
{% endhighlight %}

