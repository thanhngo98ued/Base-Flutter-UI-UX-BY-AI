# Makefile for Flutter automation

# Configure the Flutter version managed by FVM for this project
FVM_VERSION := 3.35.5

.PHONY: all get build_runner gen clean run ios android fastlane_dev fastlane_stg fastlane_prod clear_config_ios fvm_install fvm_use setup_fvm doctor

# Install FVM and select project Flutter SDK
fvm_install:
	dart pub global activate fvm

fvm_use:
	fvm use $(FVM_VERSION)

# One-shot setup: install FVM and select version
setup_fvm: fvm_install fvm_use

# Run flutter pub get
get:
	fvm flutter pub get

# Run code generation
code_gen:
	fvm dart run build_runner build --delete-conflicting-outputs

# Run pub get + code generation
build_runner: get code_gen

# Clean the build
clean:
	fvm flutter clean
	fvm flutter pub get

# Quick toolchain verification via FVM-pinned Flutter
doctor:
	fvm flutter doctor -v

# iOS clear pod
clear_config_ios:
	fvm flutter clean
	fvm flutter pub get
	cd ios && rm -rf Podfile.lock && pod install

# All in one: clean, pub get, code gen
all: clean build_runner

# Fastlane: Build + Distribute dev APK
fastlane_deploy_firebase_android_dev:
	cd android && fastlane android release_to_firebase flavor:develop

# Fastlane: Build _ Distribute dev IAP
fastlane_deploy_firebase_ios_dev:
	cd ios && fastlane ios deploy_firebase flavor:develop