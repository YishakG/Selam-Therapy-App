# Selam App

A Flutter application with a clean architecture structure.

## Project Structure

```
lib/
├── core/                           # Core functionality and infrastructure
│   ├── constants/                  # Application-wide constants
│   ├── error/                      # Error handling
│   ├── network/                    # Network layer
│   ├── providers/                  # State management
│   └── services/                   # Core services
│
├── shared/                         # Reusable components
│   ├── enums/                      # Application enums
│   ├── interfaces/                 # Interface definitions
│   ├── mixins/                     # Reusable mixins
│   ├── models/                     # Data models
│   ├── themes/                     # Theme configuration
│   └── widgets/                    # Reusable widgets
│
├── features/                       # Feature-specific code
│   └── splash/                     # Splash screen feature
│       ├── presentation/           # UI layer
│       ├── domain/                 # Business logic
│       └── data/                   # Data layer
│
├── pages/                          # Application pages
│   ├── auth/                       # Authentication pages
│   ├── home/                       # Home pages
│   ├── profile/                    # Profile pages
│   └── settings/                   # Settings pages
│
└── l10n/                          # Localization
    └── arb/                       # ARB files for translations
```

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone the repository
```bash
git clone https://github.com/yourusername/selam_app.git
```

2. Navigate to the project directory
```bash
cd selam_app
```

3. Install dependencies
```bash
flutter pub get
```

4. Run the app
```bash
flutter run
```

## Localization

The app supports English and Amharic languages. To add new translations:

1. Add new strings to `lib/l10n/arb/app_en.arb` (English)
2. Add corresponding translations to `lib/l10n/arb/app_am.arb` (Amharic)
3. Run `flutter gen-l10n` to generate localization files

## Testing

The project includes three types of tests:

- Unit tests: `test/unit/`
- Widget tests: `test/widget/`
- Integration tests: `test/integration/`

Run tests with:
```bash
flutter test
```

## Architecture

This project follows a clean architecture approach with:

- **Presentation Layer**: UI components and state management
- **Domain Layer**: Business logic and use cases
- **Data Layer**: Data sources and repositories

## Dependencies

- **State Management**: Provider and Riverpod
- **Network**: Dio and Retrofit
- **Storage**: SharedPreferences and Hive
- **UI Components**: Flutter ScreenUtil, CachedNetworkImage, Shimmer
- **Utils**: Logger, Intl, JSON Annotation, Freezed

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
