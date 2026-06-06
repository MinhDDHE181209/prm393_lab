plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.lab10_full"
    
    // SỬA LỖI 1: Nâng compileSdk lên 36 theo đúng yêu cầu của plugin hệ thống
    compileSdk = 36
    ndkVersion = flutter.ndkVersion

    compileOptions {
        // SỬA LỖI 2: Đưa Java tương thích về VERSION_1_8 và bật Desugaring
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
        isCoreLibraryDesugaringEnabled = true 
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_1_8.toString()
    }

    defaultConfig {
        applicationId = "com.example.lab10_full"
        minSdk = flutter.minSdkVersion
        
        // SỬA LỖI 1: Đồng bộ targetSdk lên 36 giống với compileSdk
        targetSdk = 36
        
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

// SỬA LỖI 2: Thêm thư viện hỗ trợ Desugaring vào khối dependencies của Gradle
dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
}

flutter {
    source = "../.."
}
