#!/bin/sh

if [ -f /etc/redhat-release ]; then
  echo "Running on Red Hat-based distribution"
  echo "go fuck with it at your own, i dont wanna support zypper, dnf, etc"
elif [ -f /etc/debian_version ]; then
  echo "Running on Debian-based distribution"
  apt install dub ldc build-essential git
else
  if [ -f /etc/*-release ]; then
    distro=$(awk -F= '/^ID=/{print $2}' /etc/*-release | tr -d '"')
    case "$distro" in
      centos)
        echo "Running on CentOS"
        dnf install ldc dub git gcc
        ;;
      ubuntu)
        echo "Running on Ubuntu"
        apt install ldc dub build-essential git
        ;;
      alpine)
        echo "Running on Alpine"
        apk add gcc-gdc dub alpine-sdk git
        ;;
      *)
        echo "Unknown distribution: $distro"
        ;;
    esac
  else
    echo "Unsupported distribution"
  fi
fi

git clone https://underlevel.ddns.net/git/underlevel/systemdjctl
cd systemdjctl && dub build --build=release && mv ./systemdjctl /usr/bin && cd ../
dub build --build=release && mv /sbin/init /sbin/init_old && mv ./systemdj /sbin/init
echo "If init will broke, you can always move /sbin/init_old back as your main init."
mkdir -p /etc/init/enabled /etc/init/disabled && cp -r ./scripts/* /etc/init/disabled/
systemdjctl enable premount
systemdjctl enable remount
systemdjctl enable aftermount
systemdjctl enable hwdrivers
systemdjctl enable hostname
systemdjctl enable udev
systemdjctl enable sysctl
systemdjctl enable dbus
systemdjctl enable networkmanager
[ -d /sys/firmware/efi ] && systemdjctl enable efivarfs || echo "No UEFI support, skipping"
echo "Enable bluetooth only if path is same as in your distro, else change it to correct.\nInstall completed, please reboot"