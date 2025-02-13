import java.io.FileInputStream
import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "fr.gouv.agir"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973" // flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "fr.gouv.agir"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        create("release") {
            val file = rootProject.file("key.properties")
            if (file.exists()) {
                val properties = Properties().apply {
                    load(FileInputStream(file))
                }
                properties.load(FileInputStream(file))
                storeFile = file(properties.getProperty("storeFile"))
                storePassword = properties.getProperty("storePassword")
                keyAlias = properties.getProperty("keyAlias")
                keyPassword = properties.getProperty("keyPassword")
            }
        }
    }

    flavorDimensions += "default"

    productFlavors {
        create("production") {
            dimension = "default"
            manifestPlaceholders["appName"] = "J’agis"
        }
        create("development") {
            dimension = "default"
            applicationIdSuffix = ".dev2"
            manifestPlaceholders["appName"] = "[D] J’agis"
        }
        create("local") {
            dimension = "default"
            applicationIdSuffix = ".local"
            manifestPlaceholders["appName"] = "[L] J’agis"
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
            // https://github.com/flutter/flutter/issues/32756#issuecomment-846705128
            ndk {
                abiFilters.addAll(listOf("armeabi-v7a", "arm64-v8a", "x86_64"))
            }
        }
        debug {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
