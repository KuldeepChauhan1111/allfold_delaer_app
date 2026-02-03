# allfold_delaer_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


# Generate model and route class file
flutter packages pub run build_runner build --delete-conflicting-outputs
dart run build_runner build --delete-conflicting-outputs

# Generate release build
flutter build apk --split-per-abi
flutter build apk --release

# Generate app icon
flutter pub run flutter_launcher_icons:main
dart run flutter_launcher_icons:main

# Rename app package, app name
dart run package_rename