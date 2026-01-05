# Android Development Container

A complete Android development environment with JDK 17, Android SDK, and Gradle.

## Included Tools

- **JDK 17** - Required for modern Android development
- **Android SDK** - Command-line tools, platform-tools, build-tools 34.0.0
- **Android Platform** - API 34 (Android 14)
- **Gradle 8.5** - Build automation

## VS Code Extensions

- Java Language Support (Red Hat)
- Java Debugger
- Gradle for Java
- Kotlin Language Support
- Docker

## Quick Start

```bash
# Verify installation
java --version
gradle --version
sdkmanager --version

# List available SDK packages
sdkmanager --list

# Create a new Android project
./demo.sh
```

## Creating an Altimeter App

After running `demo.sh`, you'll have a basic Android project structure. For an altimeter app, you'll need:

1. Add sensor permissions to `AndroidManifest.xml`:
```xml
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-feature android:name="android.hardware.sensor.barometer" android:required="true"/>
```

2. Use the barometric pressure sensor for altitude calculation:
```kotlin
val sensorManager = getSystemService(SENSOR_SERVICE) as SensorManager
val pressureSensor = sensorManager.getDefaultSensor(Sensor.TYPE_PRESSURE)
```

3. Calculate altitude from pressure using the barometric formula:
```kotlin
val altitude = SensorManager.getAltitude(SensorManager.PRESSURE_STANDARD_ATMOSPHERE, pressure)
```

## Additional SDK Components

Install more components as needed:
```bash
# Install emulator (requires KVM support)
sdkmanager "emulator" "system-images;android-34;google_apis;x86_64"

# Install NDK for native code
sdkmanager "ndk;26.1.10909125"
```
