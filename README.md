# Nichat

This is a simple Flutter chat application that uses GetX for state management, Firebase for authentication and real-time messaging, and Shared Preferences for local data storage.

## Features

- User authentication with Firebase
- Real-time chat functionality
- Local data storage using Shared Preferences

## Getting Started

### Prerequisites

- Make sure you have Flutter and Dart installed on your machine.
- Set up a Firebase project and configure it in your Flutter app. Follow the [official documentation](https://firebase.flutter.dev/docs/overview) for Firebase in Flutter.

### Installation

Clone the repository:

cd flutter_chat_app
flutter pub get
flutter run


## Configuration
### Project Structure

/lib
  /db
    - firebase_config.dart
  /auth
    - auth_controller.dart
    - chat_controller.dart
  /models
    - user.dart
    - message.dart
  /services
    - auth_service.dart
    - chat_service.dart
  /Screen
      - login_view.dart
      - signup.dart
      - chat.dart
      - chatroom.dart
    /chat
      - chat_view.dart
  main.dart

## Dependencies
- GetX: State management library
- Firebase: Firebase Core for Flutter
- Firebase Authentication: Firebase Authentication for Flutter
- Cloud Firestore: Firebase Cloud Firestore for Flutter
- Shared Preferences: Local data storage for Flutter

  get: ^4.6.6
  intl: ^0.18.1
  random_string: ^2.3.1
  lottie: ^1.2.2
  firebase_core: ^2.24.2
  firebase_auth: ^4.16.0
  firebase_messaging: ^14.7.10
  cloud_firestore: ^4.14.0
  shared_preferences: ^2.2.2
## License
  
