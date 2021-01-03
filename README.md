Phoenix
=======

This is the external Buildroot repository used to build system images and
updates for the Phoenix project.

Changelog
---------

A [changelog](https://git.xogium.me/xogium/buildroot-Phoenix/blob/phoenix-stable/changelog.md) is available so that users and developers can quickly check what changed between releases.

Sudo, and no root login
-----------------------

This project makes use of sudo for any administrative tasks the user might wish to perform. It hence disables the root account entirely, so at least one user on the system must be added in the wheel group (see below) for sudo to be usable.

Users table
-----------

By default, the project requires you create an users table to build correctly. This was not included in the external tree, as it is considered sensitive data.
For instructions on creating the table, please refer to [the buildroot user manual, chapter 26. Makeusers syntax documentation](https://buildroot.org/downloads/manual/manual.html#makeuser-syntax).

By default the path was set to $(BR2_EXTERNAL_PHOENIX_PATH)/board/Phoenix/utilities/users.table.

If you do not want an user table, or don't need one, simply modify the defconfig after renaming it, and remove the line defining it.

Building
--------

Building Phoenix is an easy process, though it requires decent hardware.

First install Buildroot's required dependencies. See:
[The buildroot user manual, chapter 2: System requirements](https://buildroot.org/downloads/manual/manual.html#requirement)

Then set up the required source code:

```
mkdir PHOENI && cd PHOENIX
wget 'https://github.com/OpenVPN/easy-rsa/releases/download/v3.0.7/EasyRSA-3.0.7.tgz'
wget 'https://git.buildroot.net/buildroot/snapshot/buildroot-2020.05.1.tar.gz'
tar -xf EasyRSA-3.0.7.tgz
tar -xf buildroot-2020.05.1.tar.gz
mv EasyRSA-3.0.7 easy-rsa
mv buildroot-2020.05.1 buildroot
git clone 'https://git.xogium.me/git/xogium/buildroot-Phoenix.git'
export BR2_EXTERNAL="$PWD/buildroot-Phoenix"
cd buildroot
for p in ../buildroot-Phoenix/buildroot-patches/*.patch; do patch -p1 < $p; done
cd ..
```

Create keys for RAUC updates:

```
cd easy-rsa
sed -i "s/extendedKeyUsage/#extendedKeyUsage/g" x509-types/code-signing
./easyrsa init-pki
./easyrsa build-ca
./easyrsa gen-req rauc
./easyrsa sign-req code-signing rauc
cd ..
cat >buildroot-Phoenix/scripts/certs.sh <<EOF
#!/bin/sh
RAUC_CERTIFICATE_AUTHORITY="$PWD/easy-rsa/pki/ca.crt"
RAUC_PRIVATE_KEY="$PWD/easy-rsa/pki/private/rauc.key"
RAUC_PUBLIC_KEY="$PWD/easy-rsa/pki/issued/rauc.crt"
EOF
```

Build the image:

```
cd buildroot
make O=output_build phoenix_defconfig
make O=output_build -j8
cd ..
```

Installing via dd
-----------------

For the initial install of Buildroot you'll need to write a full system image to your board's storage.

To flash to eMMC, first boot Linux from an SD card on the board. See [Seeed's ODYSSEY STM32MP157C Wiki page](https://wiki.seeedstudio.com/ODYSSEY-STM32MP157C/) for instructions on how to do this.

First, copy the image to the board from your build server. In this case I'll use SFTP over SSH:

```
sftp build-server:/home/jookia/PHOENIX/buildroot/output_build/images/Phoenix.img .
```

Now write it to the eMMC:

```
dd if=Phoenix.img of=/dev/mmcblk0
```

Switch to eMMC boot and reboot.

You can use this method to install updates, but it's much slower compared to RAUC.

Updating via RAUC
-----------------

To update using RAUC you'll need a server to host the files.

In this example I'll be using a web server (www.jookia.org) which serves contents from /var/www/www.jookia.org/.

First, copy RAUC bundles and keys to your server:

```
ls buildroot/output_build/images/
# Find the file ending in *.raucb
# You can also just flash Phoenix.img using dd but it takes a long time
mv buildroot/output_build/images/bundle-Phoenix.2020-09-06.raucb /var/www/www.jookia.org/
cp $PWD/easy-rsa/pki/ca.crt /var/www/www.jookia.org/
chmod a+r /var/www/www.jookia.org/ca.crt
```

Install the update on the device from the server:

```
wget 'https://www.jookia.org/ca.crt'
cp /etc/rauc/keyring.pem{,.bak}
mv ca.crt /etc/rauc/keyring.pem
rauc install https://www.jookia.org/bundle-Phoenix.2020-09-06.raucb
mv /etc/rauc/keyring.pem{.bak,}
reboot
```

* Notes:
	* The bundle file name is derived from git describe, and might differ slightly if you use a branch with committed but not yet released work. E.g: bundle-Phoenix.2020-09-06-18-g3d0589f.raucb.
	* If you have uncommitted work present in your branch, then the file name will have a 'dirty' tag added.
	* If your git index and cache become corrupted for any reason, your bundle will have a 'broken' tag added. This doesn't indicate by any means that your image is broken!

Future updates won't need to copy the keyring, a single 'rauc install'
invocation should download and install the image without trouble.

You should now be running a system you've just built (check the kernel build date):

```
uname -a
# Linux Phoenix 5.8.0 #3 SMP PREEMPT Thu Aug 6 03:21:30 EDT 2020 armv7l GNU/Linux
```
