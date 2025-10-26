plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    id("com.google.firebase.crashlytics")
    // END: FlutterFire Configuration
}

import java.util.Properties
import java.io.FileInputStream

android {
    namespace = "com.tmi.base"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.tmi.base"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    flavorDimensions += listOf("default")

    productFlavors {
        create("develop") {
            manifestPlaceholders += mapOf("applicationName" to "DEV Base")
            applicationIdSuffix = ".dev"
            dimension = "default"
        }
        create("staging") {
            manifestPlaceholders += mapOf("applicationName" to "STG Base")
            applicationIdSuffix = ".stg"
            dimension = "default"
        }
        create("production") {
            manifestPlaceholders += mapOf("applicationName" to "Base")
            dimension = "default"
        }
    }

    // Load keystore properties from fastlane/key/key.properties if present
    val keystoreProperties = Properties()
    val keystorePropertiesFile = rootProject.file("fastlane/key/key.properties")
    if (keystorePropertiesFile.exists()) {
        FileInputStream(keystorePropertiesFile).use { keystoreProperties.load(it) }
    }

    signingConfigs {
        create("dev") {
            if (keystoreProperties.isNotEmpty()) {
                val filePath = keystoreProperties.getProperty("devStoreFile")
                if (!filePath.isNullOrBlank()) storeFile = file(filePath)
                storePassword = keystoreProperties.getProperty("devStorePassword")
                keyAlias = keystoreProperties.getProperty("devKeyAlias")
                keyPassword = keystoreProperties.getProperty("devKeyPassword")
            }
        }
        create("stg") {
            if (keystoreProperties.isNotEmpty()) {
                val filePath = keystoreProperties.getProperty("stgStoreFile")
                if (!filePath.isNullOrBlank()) storeFile = file(filePath)
                storePassword = keystoreProperties.getProperty("stgStorePassword")
                keyAlias = keystoreProperties.getProperty("stgKeyAlias")
                keyPassword = keystoreProperties.getProperty("stgKeyPassword")
            }
        }
        create("prod") {
            if (keystoreProperties.isNotEmpty()) {
                val filePath = keystoreProperties.getProperty("storeFile")
                if (!filePath.isNullOrBlank()) storeFile = file(filePath)
                storePassword = keystoreProperties.getProperty("storePassword")
                keyAlias = keystoreProperties.getProperty("keyAlias")
                keyPassword = keystoreProperties.getProperty("keyPassword")
            }
        }
    }

    buildTypes {
        debug {
            signingConfig = signingConfigs.getByName("debug")
        }
        release {
            isMinifyEnabled = true
            isShrinkResources = true
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")
}
