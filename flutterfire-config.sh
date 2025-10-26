#!/bin/bash
# Script to generate Firebase configuration files for different environments/flavors
# Feel free to reuse and adapt this script for your own projects

if [[ $# -eq 0 ]]; then
  echo "Error: No environment specified. Use 'dev', 'stg', or 'prod'."
  exit 1
fi

case $1 in
  dev)
    flutterfire config \
      --project=tmi-base-fa0f6 \
      --out=lib/firebase_options_dev.dart \
      --ios-bundle-id=com.tmi.base.dev \
      --ios-out=ios/flavors/develop/GoogleService-Info.plist \
      --android-package-name=com.tmi.base.dev \
      --android-out=android/app/src/develop/google-services.json
    ;;
  stg)
    flutterfire config \
      --project=tmi-base-fa0f6 \
      --out=lib/firebase_options_stg.dart \
      --ios-bundle-id=com.tmi.base.stg \
      --ios-out=ios/flavors/staging/GoogleService-Info.plist \
      --android-package-name=com.tmi.base.stg \
      --android-out=android/app/src/staging/google-services.json
    ;;
  prod)
    flutterfire config \
      --project=tmi-base-fa0f6 \
      --out=lib/firebase_options_prod.dart \
      --ios-bundle-id=com.tmi.base \
      --ios-out=ios/flavors/production/GoogleService-Info.plist \
      --android-package-name=com.tmi.base \
      --android-out=android/app/src/production/google-services.json
    ;;
  *)
    echo "Error: Invalid environment specified. Use 'dev', 'stg', or 'prod'."
    exit 1
    ;;
esac