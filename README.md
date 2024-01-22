Funxtion’s Flutter UI kit is a collection of custom UI components designed to provide fitness content in your application. The UI kit has been developed keeping developers in mind and aims to reduce development efforts significantly. The UI kit depends on [Funxtion's Flutter SDK](https://github.com/Funxtion-International/funxtion-flutter-sdk), which provides an API client implementation.

## Features
Components library and content discovery page implementations for:

* Video Classes
* Audio Classes
* Training Plans
* Workouts
* Discovery & Search

## Getting started

Before you begin, ensure you have met the following requirements:

:white_check_mark: You have Android Studio, Xcode or Visual Studio Code installed on your computer

:white_check_mark: You have an Android Device or Emulator

:white_check_mark: You have an iOS Device or Emulator

:white_check_mark: You are familiar with the Funxtion Prototype (provided upon request)

## Usage
Make a local copy of the `funxtion-flutter-sdk` and `funxtion-flutter-ui-kit` repositories.

Include the Funxtion SDK and UI kit dependencies into your `pubspec.yaml` file:

```dart
dependencies:
  flutter:
    sdk: flutter
  funxtion: 
    path: ../funxtion-flutter-sdk-main/
  ui_tool_kit:
    path: ../funxtion-flutter-ui-kit-main/
```

Include the UI library in your application file, i.e. `main.dart`

```dart
import 'package:ui_tool_kit/ui_tool_kit.dart';
```

Integrate the navigation to the various screens:

**Content Discovery**
```dart
onPressed: () {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) 
    => const UiToolKitSDK(categoryName: CategoryName.contentDiscovery)));
}
```

**Video Classes**
```dart
onPressed: () {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) 
    => const UiToolKitSDK(categoryName: CategoryName.videoClasses)));
}
```

**Workouts**
```dart
onPressed: () {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) 
    => const UiToolKitSDK(categoryName: CategoryName.workouts)));
}
```

**Training Plans**
```dart
onPressed: () {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) 
    => const UiToolKitSDK(categoryName: CategoryName.trainingPlans)));
}
```

**Audio Classes**
```dart
onPressed: () {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) 
    => const UiToolKitSDK(categoryName: CategoryName.audioClasses)));
}
```
