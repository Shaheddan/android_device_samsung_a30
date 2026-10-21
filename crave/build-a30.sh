#!/bin/bash
# Build PixelOS 16 QPR2 (16.2) for the Samsung Galaxy A30 (a30) on a Crave build node.
# Queue it from WSL in ~/crave-a30, on Crave's LineageOS 23.2 project:
#   crave run --projectID <LOS 23.2 id> --no-patch -- "curl -sfL https://raw.githubusercontent.com/Shaheddan/android_device_samsung_a30/<commit>/crave/build-a30.sh | bash"
# WHY each step:
#  - Crave has no PixelOS project; PixelOS 16 QPR2 is built on LineageOS 23.2, so that
#    workspace is re-initialised to PixelOS's manifest and most sources are already cached;
#  - the local manifest is fetched fresh, so the node builds exactly what is on GitHub;
#  - /opt/crave/resync.sh instead of repo sync: Crave's rule, it manages their cache;
#  - the zip (~2.3 GB) is over GitHub's 2 GiB release-asset limit, so it is uploaded to
#    GoFile from the node, in this same job, before Crave clears out/.
# No `set -e`: build/envsetup.sh is not written for it; critical steps fail explicitly.
VARIANT=${VARIANT:-userdebug}
BRANCH=${BRANCH:-pixelos-16.2}
RAW=https://raw.githubusercontent.com/Shaheddan/android_device_samsung_a30/$BRANCH

repo init -u https://github.com/PixelOS-AOSP/android_manifest.git -b sixteen-qpr2 --git-lfs \
  || { echo "!! repo init failed"; exit 1; }
rm -rf .repo/local_manifests && mkdir -p .repo/local_manifests || exit 1
curl -sfL "$RAW/manifests/a30.xml" -o .repo/local_manifests/a30.xml \
  || { echo "!! could not fetch manifests/a30.xml"; exit 1; }

/opt/crave/resync.sh || { echo "!! resync failed"; exit 1; }

source build/envsetup.sh
# PixelOS's breakfast lunches custom_a30-<its current release>-$VARIANT
breakfast a30 "$VARIANT" || { echo "!! breakfast failed"; exit 1; }
m pixelos || { echo "!! build failed"; exit 1; }

bash device/samsung/a30/crave/upload-gofile.sh || { echo "!! upload failed"; exit 1; }
