# 📱 Base Flutter App

[![Flutter](https://img.shields.io/badge/Flutter-3.35.5-02569B?style=flat&logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.9.0+-0175C2?style=flat&logo=dart&logoColor=white)](https://dart.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

## 📖 Project Description

**Base Flutter App** is a mobile application built with Flutter framework, implementing **Clean Architecture** pattern to ensure clean, maintainable, and scalable code.

### ✨ Key Features

- 🏗️ **Clean Architecture** - Clear separation between layers
- 🎯 **Multi-flavor support** - Support for develop/staging/production
- 🎨 **Modern UI/UX** - Beautiful interface and great user experience
- 🔥 **Firebase Integration** - Integrated Firebase services
- 🌐 **Localization** - Multi-language support (Vietnamese/English)
- 📱 **Responsive Design** - Automatic screen size adaptation
- 🔒 **Secure Storage** - Safe data storage
- 🚀 **CI/CD Ready** - Ready for automated deployment

## 📂 Project Structure

```
base_flutter/
├── 📁 android/                     # Android platform configuration
│   ├── 📁 app/
│   │   ├── 📁 src/
│   │   │   ├── 📁 debug/           # Debug configuration
│   │   │   ├── 📁 develop/         # Development flavor
│   │   │   ├── 📁 main/            # Main Android source
│   │   │   ├── 📁 production/      # Production flavor
│   │   │   ├── 📁 profile/         # Profile configuration
│   │   │   └── 📁 staging/         # Staging flavor
│   │   └── 📄 build.gradle.kts     # Android build configuration
│   ├── 📁 fastlane/               # Android deployment automation
│   └── 📄 gradle.properties       # Gradle properties
│
├── 📁 ios/                        # iOS platform configuration
│   ├── 📁 Runner/                 # iOS app source
│   ├── 📁 flavors/                # iOS flavor configurations
│   │   ├── 📁 develop/
│   │   ├── 📁 production/
│   │   └── 📁 staging/
│   ├── 📁 fastlane/               # iOS deployment automation
│   └── 📄 Podfile                 # iOS dependencies
│
├── 📁 assets/                     # Static resources
│   ├── 📁 colors/                 # Color definitions (colors.xml)
│   ├── 📁 fonts/                  # Custom fonts (itim.ttf)
│   ├── 📁 images/                 # Image assets
│   ├── 📁 lotties/                # Lottie animations
│   ├── 📁 sound/                  # Audio files
│   └── 📁 strings/                # Localization files (.arb)
│
├── 📁 lib/                        # 🎯 Main Dart source code
│   ├── 📁 config/                 # App configuration
│   │   ├── 📄 env.dart            # Environment variables
│   │   └── 📄 flavor.dart         # Flavor configuration
│   │
│   ├── 📁 data/                   # 💾 Data Layer (Clean Architecture)
│   │   ├── 📁 mapper/             # Data transformation mappers
│   │   ├── 📁 mock/               # Mock data for testing
│   │   ├── 📁 model/              # Data models & DTOs
│   │   └── 📁 repository/         # Repository implementations
│   │
│   ├── 📁 domain/                 # 🎯 Domain Layer (Business Logic)
│   │   ├── 📁 error/              # Custom error definitions
│   │   ├── 📁 model/              # Domain/Business models
│   │   ├── 📁 repository/         # Repository interfaces
│   │   └── 📁 usecase/            # Business use cases
│   │
│   ├── 📁 presentation/           # 🎨 Presentation Layer (UI)
│   │   ├── 📁 base/               # Base classes & utilities
│   │   ├── 📁 pages/              # App screens & features
│   │   └── 📁 resources/          # UI resources & localization
│   │       └── 📁 gen/            # Generated resources
│   │
│   ├── 📁 router/                 # 🧭 Navigation & Routing
│   │   ├── 📄 app_router.dart     # GoRouter configuration
│   │   └── 📄 go_router_observer.dart # Route monitoring
│   │
│   ├── 📁 shared/                 # 🔧 Shared utilities
│   │   ├── 📁 components/         # Reusable UI components
│   │   ├── 📁 extensions/         # Dart extensions
│   │   ├── 📁 themes/             # App theming
│   │   └── 📁 utils/              # Utility functions
│   │
│   ├── 📁 di/                     # 💉 Dependency Injection
│   │   └── 📄 di.dart             # GetIt DI configuration
│   │
│   ├── 📁 firebase/               # 🔥 Firebase configurations
│   │   ├── 📄 firebase_options_dev.dart
│   │   ├── 📄 firebase_options_prod.dart
│   │   └── 📄 firebase_options_stg.dart
│   │
│   └── 📄 main.dart               # 🚀 App entry point
│
├── 📄 pubspec.yaml                # 📦 Dependencies & configuration
├── 📄 l10n.yaml                   # 🌐 Localization configuration
├── 📄 firebase.json               # 🔥 Firebase project configuration
├── 📄 Makefile                    # 🛠️ Build automation commands
└── 📄 README.md                   # 📖 This file
```

## 🏗️ Clean Architecture Overview

This project follows **Clean Architecture** principles with three main layers:

### 💾 Data Layer
- **Models**: Data Transfer Objects (DTOs) for API responses
- **Mappers**: Convert between data models and domain models  
- **Repository Implementations**: Concrete implementations of domain repositories
- **Mock Data**: Mock data for testing and development

### 🎯 Domain Layer (Business Logic)
- **Models**: Business logic entities
- **Repositories**: Abstract interfaces for data access
- **Use Cases**: Business logic operations
- **Errors**: Custom error definitions

### 🎨 Presentation Layer (UI)
- **Pages**: UI screens with BLoC pattern
- **Base Classes**: Base classes for pages and components
- **Resources**: Auto-generated UI resources and localization
- **Components**: Reusable UI widgets

## ✨ Highlighted Features

- 🎯 **Multi-flavor support** (develop/staging/production)
- 🏗️ **Clean Architecture** pattern
- 🔄 **State Management** with Flutter BLoC
- 💉 **Dependency Injection** with GetIt
- 🌐 **API Integration** with Retrofit + Dio
- 💾 **Local Database** with Drift (SQLite)
- 🌍 **Internationalization** (Vietnamese/English)
- 🔥 **Firebase Integration** (Messaging, Crashlytics)
- 🧭 **Navigation** with GoRouter
- 🚀 **CI/CD** with Fastlane
- 🎨 **Auto-generated Assets** with flutter_gen
- 🔒 **Secure Storage** with Flutter Secure Storage

## 🛠️ Technologies Used

### 🎯 Core Framework
- **Flutter** `3.35.5` - Cross-platform mobile development framework
- **Dart** `^3.9.0` - Programming language

### 🔄 State Management & Architecture
- **Flutter BLoC** `^8.1.6` - Business Logic Component pattern
- **BLoC** `^8.1.4` - State management library
- **GetIt** `^8.0.3` - Dependency injection container
- **Equatable** `^2.0.7` - Value equality comparisons

### 🎨 UI & UX
- **Flutter ScreenUtil** `^5.9.3` - Responsive screen adaptation
- **Flutter SVG** `^2.0.17` - SVG vector graphics support
- **Photo View** `^0.15.0` - Zoomable image viewer
- **Lottie** `^3.3.1` - Beautiful animations
- **Another XLider** `^3.0.2` - Customizable slider widgets
- **Image Picker** `^1.1.2` - Camera and gallery access
- **Lucide Icons Flutter** `^3.1.4` - Beautiful icon set
- **Cached Network Image** `^3.4.1` - Network image caching
- **Smooth Page Indicator** `^1.2.0+3` - Page indicators

### 🌐 Networking & API
- **Retrofit** `^4.4.2` - Type-safe HTTP client
- **Dio** `^5.8.0+1` - Powerful HTTP client
- **JSON Annotation** `^4.9.0` - JSON serialization annotations
- **Connectivity Plus** `^7.0.0` - Network connectivity monitoring

### 💾 Local Storage & Database
- **Drift** `^2.25.0` - Type-safe SQLite database
- **Drift Flutter** `^0.2.4` - Flutter integration for Drift
- **Shared Preferences** `^2.5.2` - Simple key-value storage
- **Flutter Secure Storage** `^9.2.4` - Encrypted secure storage
- **Path Provider** `^2.1.5` - File system path access

### 🔥 Firebase Services
- **Firebase Core** `^4.2.0` - Firebase SDK initialization
- **Firebase Messaging** `^16.0.3` - Push notifications
- **Firebase Crashlytics** `^5.0.3` - Crash reporting and analytics
- **Flutter Local Notifications** `^19.4.2` - Local notification management

### 🧭 Navigation & Routing
- **GoRouter** `^16.2.5` - Declarative routing solution

### 🌍 Localization & Internationalization
- **Flutter Localizations** - Built-in localization support
- **Intl** `^0.20.2` - Internationalization utilities

### 🔧 Development Tools
- **Build Runner** `^2.4.15` - Code generation runner
- **Flutter Gen Runner** `^5.10.0` - Asset code generation
- **Retrofit Generator** `^10.0.0` - API client code generation
- **JSON Serializable** `^6.9.4` - JSON serialization generation
- **Drift Dev** `^2.26.0` - Database code generation
- **Theme Tailor** `^3.0.2` - Theme code generation
- **BLoC Test** `^9.1.7` - Testing utilities for BLoC

### 🛠️ Utilities
- **Collection** `^1.18.0` - Collection utilities
- **UUID** `^4.5.1` - Unique identifier generation
- **Flutter Image Compress** `^2.4.0` - Image compression
- **FlutterToast** `^9.0.0` - Toast notifications
- **Permission Handler** `^12.0.1` - Device permissions management
- **TimeAgo** `^3.7.0` - Human-readable time differences
- **URL Launcher** `^6.3.2` - External URL and app launching

### 🐛 Debugging & Logging
- **Awesome Dio Interceptor** `^1.3.0` - Network request/response logging
- **Colorize** `^3.0.0` - Colored console output

### 🚀 CI/CD & Deployment
- **Fastlane** - Automated deployment for Android & iOS
- **Flutter Native Splash** `^2.4.5` - Splash screen generation
- **Flutter Launcher Icons** `^0.14.3` - App icon generation

### 📝 Code Quality
- **Flutter Lints** `^6.0.0` - Comprehensive linting rules
- **Change App Package Name** `^1.4.0` - Package renaming utility

## 🚀 Getting Started

### 📋 Prerequisites
Before starting, make sure you have installed:
- **Flutter SDK** `3.35.5` - [Installation Guide](https://flutter.dev/docs/get-started/install)
- **Dart SDK** `^3.9.0` - Comes with Flutter
- **Android Studio** - For Android development
- **Xcode** - For iOS development (macOS only)
- **Git** - Version control
- **FVM** (recommended) - Flutter Version Management

### 📁 Environment Setup

#### 1️⃣ Clone Repository
```bash
git clone <repository-url>
cd base_flutter
```

#### 2️⃣ Setup Flutter SDK (Recommended with FVM)

**Option A: Using Makefile (Recommended)**
```bash
# Install FVM and select Flutter version defined in Makefile
make setup_fvm
```

**Option B: Manual commands**
```bash
# Install FVM (one-time setup)
dart pub global activate fvm

# Use Flutter version pinned in project
fvm use 3.35.5

# Optional: set as global default
# fvm global 3.35.5
```

#### 3️⃣ Install FlutterFire CLI
```bash
# Install FlutterFire CLI globally for Firebase configuration
dart pub global activate flutterfire_cli
```

#### 4️⃣ Get Required Files from Team Lead
Contact **Team Lead** to obtain:
- **Environment configuration files** (`.env` files)
- **Android keystore file** (for release builds)
- **Firebase configuration files** (if not included)

#### 5️⃣ Install Dependencies & Generate Code
```bash
# Option 1: Full setup (recommended for first time)
make all

# Option 2: Step by step
make get                 # Install Flutter dependencies
make code_gen           # Generate code (models, routes, etc.)
make build_runner       # Both get + code_gen
```

#### 6️⃣ Platform-Specific Setup

**🤖 Android Setup**
```bash
# No additional setup required
# Keystore file should be placed in android/app/ directory
```

**🍎 iOS Setup**
```bash
# Clear and reinstall pods (if needed)
make clear_config_ios

# Or manually:
cd ios
rm -rf Podfile.lock
pod install
cd ..
```

## 🛠️ Available Commands

### 🔧 Development Commands  
```bash
make get                 # Install dependencies
make code_gen           # Run code generation  
make build_runner       # Install deps + generate code
make clean              # Clean build files
make all                # Full clean + setup
make doctor             # Check Flutter toolchain
```

### 🍎 iOS Specific
```bash
make clear_config_ios   # Clear iOS pods and reinstall
```

### 🚀 Deployment Commands
```bash
# Android deployment
make fastlane_deploy_firebase_android_dev

# iOS deployment  
make fastlane_deploy_firebase_ios_dev
```

## 📱 Running the App

### 🔨 Development Mode
```bash
# Run on connected device/emulator
fvm flutter run

# Run with specific flavor
fvm flutter run --flavor develop
fvm flutter run --flavor staging  
fvm flutter run --flavor production

# Run with specific target
fvm flutter run --target lib/main.dart
```

### 📦 Build for Release
```bash
# Android APK
fvm flutter build apk --flavor production

# Android App Bundle (recommended for Play Store)
fvm flutter build appbundle --flavor production

# iOS
fvm flutter build ios --flavor production
```

### 🩺 Check Toolchain
```bash
# Verify toolchain with FVM-pinned Flutter
make doctor
```

## 🔧 Troubleshooting

### ⚠️ Common Issues

**1️⃣ Code generation errors:**
```bash
make clean
make build_runner
```

**2️⃣ iOS pods errors:**
```bash
make clear_config_ios
```

**3️⃣ Dependencies conflicts:**
```bash
fvm flutter clean
fvm flutter pub get
fvm flutter pub deps
```

**4️⃣ Android build errors:**
```bash
cd android
./gradlew clean
cd ..
fvm flutter clean
fvm flutter pub get
```

**5️⃣ Firebase configuration errors:**
```bash
# Re-run FlutterFire configure
flutterfire configure
```

### 🔐 Environment Variables
Make sure all environment variables are configured in `.env` files:
- API endpoints
- API keys  
- Firebase configuration
- Other service configurations
