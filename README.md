# Socially

**Socially** is a social media-inspired Flutter app created as a task for Havebreak. It includes features like a double-tap love interaction similar to Instagram, story view auto-dismiss functionality, and offline caching for comments fetched from a dummy JSON API.

## Demo

[Click here to go to demo then press view raw to download it](assets/demo.mp4)


## Apk

- Go to assets folder and download the app-release.apk

## Features

### 1. Custom App Icon, Name, and Splash Screen
- Updated the app icon to align with the project’s theme.
- Customized the app’s native splash screen for an improved initial user experience.
- Changed the app name and label for a personalized look and feel.

### 2. Double-Tap Love Interaction
- Added a double-tap love interaction on posts, similar to Instagram’s like feature.
- Users can double-tap on a post to trigger an animated heart icon, enhancing engagement and feedback.

### 3. Story Auto-Dismissal
- Implemented an automatic pop behavior for the story viewer.
- After a story’s view timer expires, the app automatically dismisses the story and navigates back, providing a smooth, intuitive user experience.

### 4. Comments API Integration with Offline Caching
- Integrated comments from a dummy JSON API to simulate user interactions.
- Implemented caching for comments using Hive; comments are stored locally on the device and retrieved when there is no internet connection, allowing for offline viewing.

## Dependencies

Below is a summary of the main packages used in this project:

- **[animated_theme_switcher](https://pub.dev/packages/animated_theme_switcher)**: For theme switching animations.
- **[bloc](https://pub.dev/packages/bloc)** and **[flutter_bloc](https://pub.dev/packages/flutter_bloc)**: State management solution for reactive and predictable app states.
- **[connectivity_plus](https://pub.dev/packages/connectivity_plus)**: For checking network connectivity.
- **[dio](https://pub.dev/packages/dio)**: For handling network requests.
- **[easy_localization](https://pub.dev/packages/easy_localization)**: For managing multi-language support.
- **[equatable](https://pub.dev/packages/equatable)**: Simplifies value comparison in Bloc events and states.
- **[flutter_screenutil](https://pub.dev/packages/flutter_screenutil)**: For responsive UI design across different screen sizes.
- **[freezed](https://pub.dev/packages/freezed)** and **[freezed_annotation](https://pub.dev/packages/freezed_annotation)**: For data classes, immutability, and union types.
- **[get_it](https://pub.dev/packages/get_it)** and **[injectable](https://pub.dev/packages/injectable)**: Dependency injection to improve code modularity and testability.
- **[go_router](https://pub.dev/packages/go_router)**: Simplifies navigation and routing management.
- **[hive](https://pub.dev/packages/hive)** and **[hive_flutter](https://pub.dev/packages/hive_flutter)**: Local key-value database for offline caching of data like comments.
- **[shimmer](https://pub.dev/packages/shimmer)**: Provides a shimmer effect for loading states.
- **[shared_preferences](https://pub.dev/packages/shared_preferences)**: Used to persist small pieces of user preferences or session data.

## Getting Started

### Prerequisites

- Ensure that you have the Flutter SDK installed.
- This project uses the `build_runner` package for code generation. Run the following commands to set up the code generation:

  ```bash
  flutter pub get
  flutter pub run build_runner build --delete-conflicting-outputs
  flutter run
    

