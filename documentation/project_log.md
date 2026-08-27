## Activity Log

### 8/21/2026
- cloned git repo to windows
- setup this file
- cloned git repo to Ubuntu VM
- Setup Rasberry Pi 4B (4GB ram)
    - interfaced with the camera module 3 using the built in 'apps' (i.e. `rpicam-hello --timeout 10000`) detailed here: https://www.raspberrypi.com/documentation/computers/camera_software.html
    - installed opencv using quick install method detailed here: https://opencv-opencv.mintlify.app/installation#linux


### 8/21-8/27/2026
- research potential project ideas

### 8/27/2026
## repo setup on VM
Start in `/home/ryan/projects/final-project-ryanchallacombe`
Following the procedure here:
https://github.com/cu-ecen-aeld/buildroot-assignments-base/wiki/Setting-up-Buildroot-for-Hardware-Builds

# Step 1
Run:
```
git remote add buildroot-base https://github.com/cu-ecen-5013/buildroot-assignments-base.git
git fetch buildroot-base
git merge buildroot-base/master # resulted in conflict so did....
git config pull.rebase false
git pull buildroot-base master --allow-unrelated-histories
```
Note: documentataion for the class sometimes uses `buildroot-base` and sometimes `buildroot-assignments-base`. It depends on what we named the remove when we added it (I think). We are using `buildroot-base` as seen below:
```
ryan@Ubuntu22:~/projects/final-project-ryanchallacombe$ git remote -v
buildroot-base  https://github.com/cu-ecen-5013/buildroot-assignments-base.git (fetch)
buildroot-base  https://github.com/cu-ecen-5013/buildroot-assignments-base.git (push)
origin  git@github.com:cu-ecen-aeld/final-project-ryanchallacombe.git (fetch)
origin  git@github.com:cu-ecen-aeld/final-project-ryanchallacombe.git (push)
```
# Step 2
reference: https://github.com/cu-ecen-aeld/buildroot-assignments-base/wiki/Raspberry-Pi-Hardware-Support
```
ryan@Ubuntu22:~/projects/final-project-ryanchallacombe$ git fetch buildroot-base
ryan@Ubuntu22:~/projects/final-project-ryanchallacombe$ git merge buildroot-base/hw-rpi
error: The following untracked working tree files would be overwritten by merge:
    README.md
Please move or remove them before you merge.
Aborting
```
Let's move the README.md file temporarily. 
`git merge buildroot-base/hw-rpi`

Then I did an add / commit / push. 

# Step 3
- Modified the shared.sh file per this link: https://github.com/cu-ecen-aeld/rpi4_buildroot/blob/master/shared.sh
    as instructed at bottom of: https://github.com/cu-ecen-aeld/buildroot-assignments-base/wiki/Setting-up-Buildroot-for-Hardware-Builds
- git add / commit / push
- created a clean.sh based on this reference: https://github.com/cu-ecen-aeld/final-project-tiba6275/blob/master/clean.sh
- ran it, but it did nothing b/c the buildroot dir is empty
- ran build.sh
    appears to have completed successfully.... `onfiguration written to /home/ryan/projects/final-project-ryanchallacombe/buildroot/.config`
- 
# Step 4
before anything, I note that the file here `base_external/configs/aesd_rpi_defconfig` still calls out the rpi3. Note sure when this will be updated.
- Run `make menuconfig` from buildroot dir
    - enable compiler caching
    - created root password
    Take steps to enable wifi as specified here: https://github.com/cu-ecen-aeld/buildroot-assignments-base/wiki/Wifi-Configuration
    - changed the C lib to glibc (was uClibc-ng))
    - -> System Configuration > /dev management > Dynamic using devtmpfs + mdev
    - -> System Configuration > Root filesystem overlay directories > ../base_external/rootfs_overlay 
    - -> Target packages > hardware handling > Firmware > rpi-wifi-firmware or brcmfmac-sdio-firmware-rpi-wifi(under brcmfmac-sdio-firmware-rpi) 
    - -> Target packages -> Networking applications -> wpa_supplicant and select nl80211 support, autoscan, wpa_passphrase binary.
    - -> Target packages -> Networking applications -> dropbear 

- Updated the rootfs overlay dir as specified here: https://github.com/cu-ecen-aeld/buildroot-assignments-base/wiki/Wifi-Configuration
- add wpa_supplicant.conf to the .gitignore file b/c it contains wifi password
- ran `save-config.sh`

This still looks wrong...
```
ryan@Ubuntu22:~/projects/final-project-ryanchallacombe$ cat base_external/configs/aesd_rpi_defconfig
BR2_arm=y
BR2_cortex_a53=y
BR2_ARM_FPU_NEON_VFPV4=y
BR2_PACKAGE_HOST_LINUX_HEADERS_CUSTOM_5_10=y
BR2_TOOLCHAIN_BUILDROOT_CXX=y
BR2_SYSTEM_DHCP="eth0"
BR2_ROOTFS_POST_BUILD_SCRIPT="board/raspberrypi3/post-build.sh"
BR2_ROOTFS_POST_IMAGE_SCRIPT="board/raspberrypi3/post-image.sh"
BR2_LINUX_KERNEL=y
BR2_LINUX_KERNEL_CUSTOM_TARBALL=y
BR2_LINUX_KERNEL_CUSTOM_TARBALL_LOCATION="$(call github,raspberrypi,linux,0b54dbda3cca2beb51e236a25738784e90853b64)/linux-0b54dbda3cca2beb51e236a25738784e90853b64.tar.gz"
BR2_LINUX_KERNEL_DEFCONFIG="bcm2709"
BR2_LINUX_KERNEL_DTS_SUPPORT=y
BR2_LINUX_KERNEL_INTREE_DTS_NAME="bcm2710-rpi-3-b bcm2710-rpi-3-b-plus bcm2710-rpi-cm3"
BR2_LINUX_KERNEL_NEEDS_HOST_OPENSSL=y
BR2_PACKAGE_RPI_FIRMWARE=y
BR2_PACKAGE_RPI_FIRMWARE_BOOTCODE_BIN=y
BR2_PACKAGE_RPI_FIRMWARE_VARIANT_PI=y
BR2_PACKAGE_RPI_FIRMWARE_CONFIG_FILE="board/raspberrypi3/config_3.txt"
BR2_TARGET_ROOTFS_EXT2=y
BR2_TARGET_ROOTFS_EXT2_4=y
BR2_TARGET_ROOTFS_EXT2_SIZE="120M"
# BR2_TARGET_ROOTFS_TAR is not set
BR2_PACKAGE_HOST_DOSFSTOOLS=y
BR2_PACKAGE_HOST_GENIMAGE=y
BR2_PACKAGE_HOST_MTOOLS=y
```
Found the issue. The shared.sh script was causing the save-config.sh script to write to /home/ryan/projects/final-project-ryanchallacombe/base_external/configs/aesd_qemu_deconfig. I updated shared.sh to save to aesd_raspberrypi4_64_defconfig in that directory. 

TODO: compare https://github.com/cu-ecen-aeld/final-project-abbottwhitley/blob/master/base_external/configs/aesd_pi4_defconfig with mine 