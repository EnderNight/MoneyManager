#!/bin/bash

VERSION=$(cat money_manager/pubspec.yaml | grep version | cut -d ':' -f 2 | xargs)

rm -vrf build/

mkdir -vp build/{android,linux}

pushd money_manager

flutter clean && flutter pub get

# Android
flutter build apk --split-per-abi &&

# Linux
flutter build linux

popd

# Android
mv -v "money_manager/build/app/outputs/flutter-apk/app-arm64-v8a-release.apk" "build/android/money-manager-v${VERSION}-android.apk"
mv -v "money_manager/build/app/outputs/flutter-apk/app-arm64-v8a-release.apk.sha1" "build/android/money-manager-v${VERSION}-android.apk.sha1"

zip -rj "build/android/money-manager-v${VERSION}-android.zip" "build/android/money-manager-v${VERSION}-android.apk" "build/android/money-manager-v${VERSION}-android.apk.sha1"

# Linux
mv -v "money_manager/build/linux/x64/release/bundle" "build/linux/money-manager-v${VERSION}-linux"

find "build/linux/money-manager-v${VERSION}-linux" -type f -print0 | sort -z | xargs -0 sha1sum | sha1sum > "build/linux/money-manager-v${VERSION}-linux/money-manager-v${VERSION}-linux.sha1"

tar czvf "build/linux/money-manager-v${VERSION}-linux.tar.gz" -C 'build/linux/' "money-manager-v${VERSION}-linux/"

###
mv -v "build/android/money-manager-v${VERSION}-android.zip" build/
mv -v "build/linux/money-manager-v${VERSION}-linux.tar.gz" build/

rm -vrf build/android/ build/linux/
