# Favorite Places App 📍

A beautiful Flutter application that allows users to save and manage their favorite places with photos, locations, and interactive maps.

## 🌟 Features

### Core Functionality
- **Add New Places**: Create entries for your favorite locations
- **Photo Integration**: Capture photos using camera or select from gallery
- **Location Services**: Get current GPS location automatically
- **Interactive Maps**: View places on Google Maps with custom markers
- **Address Geocoding**: Convert coordinates to human-readable addresses
- **Local Storage**: Store all data locally using SQLite database
- **Image Management**: Automatically save and manage photos locally

### User Interface
- **Modern Dark Theme**: Beautiful dark UI with purple accent colors
- **Responsive Design**: Optimized for various screen sizes
- **Smooth Animations**: Enhanced user experience with loading indicators
- **Image Gallery**: Horizontal scrollable image gallery on home screen
- **Place Details**: Detailed view with photos, maps, and location info

## 📱 Screenshots

> **Note**: Add your app screenshots here in the following format:

![Image](https://github.com/user-attachments/assets/2efdc49f-6212-4a99-bccd-ffc793c2c7b7)
![Image](https://github.com/user-attachments/assets/e636f19a-5f76-42af-9e71-3a8d8f2d7774)
![Image](https://github.com/user-attachments/assets/03bd4b81-4b12-42ef-9103-9f760f9318e2)
![Image](https://github.com/user-attachments/assets/f3b79803-e8ab-4204-aadb-fe7d780a624b)
![Image](https://github.com/user-attachments/assets/32c7edba-8509-4332-97bf-2d2b158831df)

## 🛠 Tech Stack

### Framework & Language
- **Flutter**: Cross-platform mobile development framework
- **Dart**: Programming language

### Key Dependencies
- **flutter_riverpod**: State management solution
- **sqflite**: Local SQLite database
- **google_maps_flutter**: Google Maps integration
- **image_picker**: Camera and gallery access
- **location**: GPS location services
- **geocoding**: Address conversion from coordinates
- **google_fonts**: Custom typography (Ubuntu Condensed)
- **path_provider**: File system access

### Architecture
- **Provider Pattern**: Using Riverpod for state management
- **SQLite Database**: Local data persistence
- **File System**: Local image storage
- **MVC Pattern**: Separation of concerns with models, views, and controllers

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Android Studio / VS Code with Flutter extensions
- Android/iOS device or emulator
- Google Maps API key (for map functionality)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/favorite-places-app.git
   cd favorite-places-app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Google Maps API**
   - Get your API key from [Google Cloud Console](https://console.cloud.google.com/)
   - Replace the API key in `lib/api/api_key.dart`:
   ```dart
   class ApiKey {
     static const String key = "YOUR_GOOGLE_MAPS_API_KEY_HERE";
   }
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Platform-specific Setup

#### Android
- Add Google Maps API key to `android/app/src/main/AndroidManifest.xml`
- Ensure location permissions are configured

#### iOS
- Add Google Maps API key to `ios/Runner/AppDelegate.swift`
- Configure location permissions in `Info.plist`

## 📂 Project Structure

```
lib/
├── api/
│   └── api_key.dart                 # Google Maps API configuration
├── models/
│   └── location_data.dart           # Location data model
├── pages/
│   ├── add_place_page.dart         # Add new place screen
│   ├── home_page.dart              # Main home screen
│   └── place_details_page.dart     # Place details screen
├── providers/
│   └── location_provider.dart      # State management & database operations
├── widgets/
│   ├── add_image_widget.dart       # Image display component
│   ├── add_place_form.dart         # Place creation form
│   ├── list_places_widget.dart     # Places list component
│   ├── place_details_widget.dart   # Place details display
│   ├── scrollable_row_image.dart   # Horizontal image gallery
│   ├── show_location.dart          # Location display component
│   └── show_maps.dart              # Google Maps widget
└── main.dart                       # App entry point
```

## ✨ Key Features Explained

### 1. **Smart Location Detection**
- Automatically detects current GPS location
- Converts coordinates to readable addresses
- Handles location permissions gracefully

### 2. **Photo Management**
- Take photos directly with camera
- Select existing photos from gallery
- Automatic local storage and optimization

### 3. **Database Integration**
- SQLite for reliable local storage
- Automatic database creation and migrations
- Efficient data retrieval and management

### 4. **Interactive Maps**
- Multiple map styles and border effects
- Custom markers for saved locations
- Zoom and pan functionality
- Beautiful visual effects (neon, gradient, glass styles)

### 5. **State Management**
- Riverpod for reactive state management
- Automatic UI updates when data changes
- Clean separation of business logic

## 🎨 Customization

### Theme Customization
The app uses a dark theme with customizable colors:
```dart
final colorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 102, 6, 247), // Purple accent
  background: const Color.fromARGB(255, 56, 49, 66),
);
```

### Map Styles
Choose from multiple map border styles:
- Modern
- Elegant  
- Neon
- Gradient
- Glass
- Classic
- Floating

## 🔒 Permissions Required

### Android
- `ACCESS_FINE_LOCATION`: For GPS location access
- `ACCESS_COARSE_LOCATION`: For network-based location
- `CAMERA`: For taking photos
- `READ_EXTERNAL_STORAGE`: For accessing gallery
- `WRITE_EXTERNAL_STORAGE`: For saving images

### iOS
- Location Services: "This app uses location to tag your favorite places"
- Camera: "This app uses camera to capture photos of your places"
- Photo Library: "This app accesses photos to attach to your places"

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🐛 Known Issues

- None currently reported

## 📞 Support

If you encounter any issues or have questions:
- Open an issue on GitHub
- Contact: [your-email@example.com]

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Google Maps Platform for mapping services
- Riverpod community for state management solutions
- Contributors and testers

---

**Made with ❤️ using Flutter**
