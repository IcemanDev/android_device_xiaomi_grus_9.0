# android_device_xiaomi_grus_9.0
For building TWRP for Mi 9 SE

TWRP device tree for Mi 9 SE

## Compile
First configure repo, git and java.
Second checkout minimal twrp with omnirom tree:

```
sudo repo init -u git://github.com/minimal-manifest-twrp/platform_manifest_twrp_omni.git -b twrp-9.0
sudo repo sync
```

Follow these commands from the terminal:

```
. build/envsetup.sh
lunch omni_grus-eng
or
breakfast grus eng
mka adbd recoveryimage ALLOW_MISSING_DEPENDENCIES=true
```

Installation and testing:

```
fastboot boot out/target/product/grus/recovery.img
```
