
name: Build Anti Maling APK

on:
  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - uses: actions/setup-java@v4
        with:
          distribution: temurin
          java-version: '17'

      - uses: subosito/flutter-action@v2
        with:
          channel: stable

      - name: Build APK
        run: |
          test -f anti_maling/lib/main.dart
          flutter create --platforms=android anti_maling
          flutter pub get --directory anti_maling
          flutter build apk --release --project-dir anti_maling

      - uses: actions/upload-artifact@v4
        with:
          name: anti-maling-apk
          path: anti_maling/build/app/outputs/flutter-apk/app-release.apk
            
