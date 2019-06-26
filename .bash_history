ssh shakeel@eden
sudo visudo
dmesg
dmesg | more
vi mtrr-failure.md
cat mtrr-failure.md 
vi mtrr-failure.md 
ssh shakeel@eden
ls -al
ls
mkdir bin
cd .local/
mkdir bin
cd bin/
ls
cd
sudo vim /etc/default/grub 
sudo vi /etc/default/grub 
sudo update-grub
ls -al
scp shakeel@eden:horizon/.bash_aliases .
scp shakeel@eden:horizon/.bash_functions .
ls -al
vi .profile
vi .bashrc
cd
ssh shakeel@eden
dmesg
sudo lshw
sudo apt-get update
sudo apt-get upgrade
uname -a
lsb_release -a
cd /usr/share/
ls
cd ..
cd src
ls
uname -r
dmesg | grep -e IOMMU
dmesg | grep -e DMAR
cd
cat /proc/cmdline
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common build-essential pkg-config zip g++ zlib1g-dev unzip python tree htop
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install vim ctags vim-doc vim-scripts 
sudo apt-get install gcc-multilib
sudo apt-get install msr-tools
sudo apt-get install automake autoconf-archive gnu-standards autoconf-doc libtool m4-doc
sudo apt-get install libpcap-dev libmnl-dev libnuma-dev
lstopo
sudo apt-get install hwloc
lstopo
sudo apt-get install rdma-core
ls /usr/include/
sudo apt-get install libfabric-dev
ls /usr/include/
sudo apt-get install dapl2-utils libdapl-dev libdapl2
ls /usr/include/
sudo apt-get install ibacm librdmacm-dev rdmacm-utils
systemctl status ibacm.service
journalctl -xe
sudo apt-get update
sudo apt-get upgrade
systemctl status
systemctl status --failed
systemctl --help
systemctl --failed
cd /usr/src/linux-headers-4.18.0-22-generic/
ls
cd crypto
ls
cd
cd devel/openvswitch-2.11.1/
ls
cd datapath/linux/
ls
ls *.ko
sudo insmod openvswitch.ko 
sudo lsmod | grep vport
sudo lsmod | grep open
sudo lsmod | sort | more
la
sudo update-ca-certificates 
apt info libelf-dev
apt
apt show libelf-dev
apt show libelf-devel
apt show elfutils-libelf-devel
sudo apt-get install libelf-dev
cd /dev
ls
ls u*
ls h*
la h*
sudo grep HugePage_ /proc/meminfo 
sudo grep HugePages_ /proc/meminfo 
cd
dmesg | grep -e DMAR -e IOMMU
cpufrequtils
i7z
cpupower
sudo apt install i7z linux-tools-common
cpupower
sudo apt-get install linux-tools-generic
cpupower 
i7z
sudo i7z
ssh shakeel@eden
cd devel
cd openvswitch-2.11.1/
ls
sudo make install
cd /usr/include/
ls
cd ..
cd share/openvswitch/
ls
cd /var
la
cd run
la
cd
cd devel/openvswitch-2.11.1/
sudo make modules_install
ls
systemctl status
sudo apt-get install openssh-server
la
alias
la
pip list
sudo apt install python-pip
pip list
pip3 list
sudo apt install python3-pip
pip3 list
ls
dmesg
lstopo
sudo lscpu
sudo lspci
sudo apt-get update
sudo apt-get upgrade
sudo apt autoremove
uname -a
cd /usr/include/
ls
cd infiniband/
ls
cd
mkdir devel
mkdir go
mkdir go/src
mkdir go/bin
mkdir go/pkg
ls
tree
uname -a
sudo apt install libssl-dev libcap-ng-dev net-tools ethtool nmap socat tshark ngrep inetutils-traceroute graphviz xdot
sudo apt-get install ndiff
cd Downloads/
ls
rm google-chrome-stable_current_amd64.deb 
scp shakeel@eden:swtch/*.tar.* .
scp shakeel@eden:swtch/*.exe .
scp shakeel@eden:swtch/*.bin .
la
sudo apt-get install python3-venv
pip install numpy
pip3 install numpy
la
sudo tar -C /usr/local -xf go1.12.6.linux-amd64.tar.gz 
cd
vim .profile
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
which go
go env
go version
go help
go list
cd Downloads/
la
sudo tar -C /usr/src -xf dpdk-18.11.1.tar.xz 
cd /usr/src/dpdk-stable-18.11.1/
$pwd
echo $pwd
echo $PWD
export DPDK_DIR=$PWD
cd
cd $DPDK_DIR
ls
env
export DPDK_TARGET=x86_64-native-linuxapp-gcc
export DPDK_BUILD=$DPDK_DIR/$DPDK_TARGET
env | grep DPDK
vim ~/.profile 
env | grep PATH
sudo make install T=$DPDK_TARGET DESTDIR=install
cd install
ls
sudo /sbin/lsmod | grep openvswitch
dmesg | tail
dmesg
systemctl status
systemctl status openssh
systemctl status ssh
sudo mkdir /mnt/huge
sudo mount -t hugetlbfs nodev /mnt/huge
cd /mnt
la
sudo vim /etc/fstab
grep hpet /proc/timer_list
sudo grep hpet /proc/timer_list
cd $DPDK_DIR
sudo make install T=$DPDK_TARGET DESTDIR=install CONFIG_RTE_LIBEAL_USE_HPET=y
sudo rm -rf install/
sudo make install T=$DPDK_TARGET DESTDIR=install CONFIG_RTE_LIBEAL_USE_HPET=y
ls
cd install/
ls
tree
ls
cd ..
la
vim README 
cd doc/
ls
cd guides/
ls
cd howto/
ls
cd ..
ls
sudo make clean install T=$DPDK_TARGET DESTDIR=install CONFIG_RTE_LIBEAL_USE_HPET=y
sudo make install T=$DPDK_TARGET DESTDIR=install CONFIG_RTE_LIBEAL_USE_HPET=y
cd install/
ls
cd lib/
ls
cd modules/
ls
cd 4.18.0-22-generic/
ls
cd extra/
ls
cd dpdk/
ls
cd $DPDK_DIR
ls
la kernel/
la kernel/linux/
la kernel/linux/kni/
ls
cd x86_64-native-linuxapp-gcc/
ls
cd kmod/
ls
sudo lsmod
cd ..
sudo rm -rf x86_64-native-linuxapp-gcc/
sudo make install T=$DPDK_TARGET DESTDIR=install CONFIG_RTE_LIBEAL_USE_HPET=y
cpupower frequency-info
sudo apt-get install linux-tools-4.18.0-22-generic
cpupower frequency-info
sudo cpupower frequency-info
ls /usr/lib/modules/$(uname -r)/kernel/drivers/cpufreq/
sudo ls /usr/lib/modules/$(uname -r)/kernel/drivers/cpufreq/
sudo cpupower frequency-set -g performance
sudo cpupower frequency-info
sudo lscpu
ls
ls devtools/
ls usertools/
./usertools/dpdk-devbind.py --status
ls
./usertools/dpdk-devbind.py --status
cd
cd devel
ls
la ~/Downloads/
tar -xvf ~/Downloads/openvswitch-2.11.1.tar.gz 
la
cd openvswitch-2.11.1/
ls
./boot.sh 
./configure --prefix=/usr --localstatedir=/var --sysconfdir=/etc --with-linux=/lib/modules/$(uname -r)/build --with-dpdk=$DPDK_BUILD
make
env | sort
make check
make check-oftest OFT=$HOME/devel/oftest/oft
sudo make check-oftest OFT=$HOME/devel/oftest/oft
clear
sudo grep hpet /proc/timer_list
ls
cd $DPDK_DIR
ls
cd x86_64-native-linuxapp-gcc/
ls
ls include/
cd ..
la
cd examples/
la
cd ..
cd x86_64-native-linuxapp-gcc/
la
cd ..
cd install/
la
tree
la
cd dpdk/
la
cd .
ls
cd ..
la
cd ..
la
cd bin/
la
cd ..
la
la lib/
la lib/modules/
la lib/modules/4.18.0-22-generic/
la lib/modules/4.18.0-22-generic/extra/
la lib/modules/4.18.0-22-generic/extra/dpdk/
cd
sudo vim /etc/default/grub
sudo update-grub
cat /proc/cmdline
cd Downloads/
la
cd
cd devel
git clone https://github.com/floodlight/oftest.git
sudo apt-get update
sudo apt-get install git
git clone https://github.com/floodlight/oftest.git
ls
cd oftest/
la
htop
sudo apt-get install scapy
./oft --list
which tcpdump
la
sudo lsmod | grep -i pci
sudo lsmod | grep -i vfio
sudo lsmod | more
cd /usr/share/
la
cd ..
ls
cd lib
ls
cd /etc
ls
cd openvswitch/
ls
la
cd /lib
ls
cd x86_64-linux-gnu/
ls
cd ..
ls
cd modules/
la
cd 4.18.0-22-generic/
la
cd extra/
la
sudo lspci
lstopo
dmesg
update
sudo apt-get update
sudo apt-get upgrade
sudo apt autoremove
la
sudo apt-get update
