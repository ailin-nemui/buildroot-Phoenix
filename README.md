This is the external Buildroot repository used to build system images and
updates for the MynaPlayer project.

Changelog
--------

A [changelog](https://git.lumina-sensum.com/LuminaSensum/buildroot-MynaPlayer/blob/stable-dev-board/changelog.md) is available so that users and developers can quickly check what changed between releases.

Building
--------

Building MynaPlayer is an easy process, though it requires decent hardware.

First install Buildroot's required dependencies. See:
[The buildroot user manual, chapter 2: System requirements](https://buildroot.org/downloads/manual/manual.html#requirement)

Then set up the required source code:

```
mkdir MYNA && cd MYNA
wget 'https://github.com/OpenVPN/easy-rsa/releases/download/v3.0.7/EasyRSA-3.0.7.tgz'
wget 'https://git.buildroot.net/buildroot/snapshot/buildroot-2020.05.1.tar.gz'
tar -xf EasyRSA-3.0.7.tgz
tar -xf buildroot-2020.05.1.tar.gz
mv EasyRSA-3.0.7 easy-rsa
mv buildroot-2020.05.1 buildroot
git clone 'https://git.lumina-sensum.com/git/LuminaSensum/buildroot-MynaPlayer.git'
export BR2_EXTERNAL="$PWD/buildroot-MynaPlayer"
cd buildroot
for p in ../buildroot-MynaPlayer/buildroot-patches/*.patch; do patch -p1 < $p; done
cd ..
```

Create keys for RAUC updates:

```
cd easy-rsa
sed -i "s/extendedKeyUsage/#extendedKeyUsage/g" easyrsa3/x509-types/code-signing
./easyrsa3/easyrsa init-pki
./easyrsa3/easyrsa build-ca
./easyrsa3/easyrsa gen-req rauc
./easyrsa3/easyrsa sign-req code-signing rauc
cd ..
cat >buildroot-MynaPlayer/scripts/certs.sh <<EOF
#!/bin/sh
RAUC_CERTIFICATE_AUTHORITY="$PWD/easy-rsa/pki/ca.crt"
RAUC_PRIVATE_KEY="$PWD/easy-rsa/pki/private/rauc.key"
RAUC_PUBLIC_KEY="$PWD/easy-rsa/pki/issued/rauc.crt"
EOF
```

Build the image:

```
cd buildroot
make O=output_build myna_player_odyssey_defconfig
make O=output_build -j8
cd ..
```

Installing via dd
-----------------

For the initial install of Buildroot you'll need to write a full system image to your board's storage.

To flash to eMMC, first boot Linux from an SD card on the board. See [Seeed's ODYSSEY STM32MP157C Wiki page](https://wiki.seeedstudio.com/ODYSSEY-STM32MP157C/) for instructions on how to do this.

First, copy the image to the board from your build server. In this case I'll use SFTP over SSH:

```
sftp build-server:/home/jookia/MYNA/buildroot/output_build/images/MynaPlayer.img .
```

Now write it to the eMMC:

```
dd if=MynaPlayer.img of=/dev/mmcblk0
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
# You can also just flash MynaPlayer.img using dd but it takes a long time
mv buildroot/output_build/images/bundle-MynaPlayer.2020-09-06.raucb /var/www/www.jookia.org/
cp $PWD/easy-rsa/pki/ca.crt /var/www/www.jookia.org/
chmod a+r /var/www/www.jookia.org/ca.crt
```

Install the update on the device from the server:

```
wget 'https://www.jookia.org/ca.crt'
cp /etc/rauc/keyring.pem{,.bak}
mv ca.crt /etc/rauc/keyring.pem
rauc install https://www.jookia.org/bundle-MynaPlayer.2020-09-06.raucb
mv /etc/rauc/keyring.pem{.bak,}
reboot
```

* Notes:
	* The bundle file name is derived from git describe, and might differ slightly if you use a branch with committed but not yet released work. E.g: bundle-MynaPlayer.2020-09-06-18-g3d0589f.raucb.
	* If you have uncommitted work present in your branch, then the file name will have a 'dirty' tag added.
	* If your git index and cache become corrupted for any reason, your bundle will have a 'broken' tag added. This doesn't indicate by any means that your image is broken!

Future updates won't need to copy the keyring, a single 'rauc install'
invocation should download and install the image without trouble.

You should now be running a system you've just built (check the kernel build date):

```
uname -a
# Linux MynaPlayer 5.8.0 #3 SMP PREEMPT Thu Aug 6 03:21:30 EDT 2020 armv7l GNU/Linux
```
