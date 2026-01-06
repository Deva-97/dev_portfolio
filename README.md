
# Dev Portfolio

A cross-platform developer portfolio built with Flutter. This project showcases your professional experience, skills, and projects in a modern, responsive UI. It supports web, Android, and Windows platforms.

## Features
- Responsive design for web and mobile
- Sections for About, Experience, Projects, and Contact
- Animated transitions and interactive widgets
- Organized code structure for scalability
- Easy to customize with your own data

## Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Dart SDK (included with Flutter)
- (Optional) Android Studio or Visual Studio Code for development

### Installation
1. Clone the repository:
    ```sh
    git clone <your-repo-url>
    cd dev_portfolio
    ```
2. Get dependencies:
    ```sh
    flutter pub get
    ```
3. Run the app:
    - **Web:**
       ```sh
       flutter run -d chrome
       ```
    - **Android:**
       ```sh
       flutter run -d android
       ```
    - **Windows:**
       ```sh
       flutter run -d windows
       ```

## Project Structure
- `lib/` - Main Dart codebase
   - `core/` - Theme and utilities
   - `data/` - Data models and sources
   - `presentation/` - Screens and widgets
- `assets/` - Images and other assets
- `web/` - Web-specific files
- `android/`, `windows/` - Platform-specific files

## Customization
- Update your experience and project data in `lib/data/data_sources/`
- Change theme colors in `lib/core/theme/`
- Add images to `assets/images/`

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.
