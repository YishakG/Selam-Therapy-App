# Folder Structure

```
lib/
├── core/                     # Core functionality and utilities
│   ├── constants/           # App-wide constants
│   ├── theme/              # App theme and styling
│   ├── utils/              # Utility functions
│   ├── widgets/            # Shared widgets
│   ├── providers/          # State management providers
│   ├── services/           # Core services (auth, api, etc.)
│   └── network/            # Network related code
│
├── features/               # Feature modules
│   ├── auth/              # Authentication feature
│   │   ├── data/         # Data layer (repositories, models)
│   │   ├── domain/       # Business logic
│   │   └── presentation/ # UI layer (pages, widgets)
│   │
│   ├── home/             # Home feature
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── video/            # Video feature
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── onboarding/       # Onboarding feature
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   └── splash/           # Splash screen feature
│       └── presentation/
│
├── l10n/                  # Localization
│   ├── app_am.arb        # Amharic translations
│   └── app_en.arb        # English translations
│
└── main.dart             # App entry point
```

## Directory Purposes

- **core/**: Contains all the core functionality that is shared across features
  - **constants/**: App-wide constants like colors, sizes, etc.
  - **theme/**: App theme configuration
  - **utils/**: Helper functions and utilities
  - **widgets/**: Reusable widgets used across features
  - **providers/**: Global state management
  - **services/**: Core services like authentication, API
  - **network/**: Network related code (API client, interceptors)

- **features/**: Contains all the feature modules
  Each feature follows clean architecture with:
  - **data/**: Data layer (repositories, models, data sources)
  - **domain/**: Business logic (use cases, entities)
  - **presentation/**: UI layer (pages, widgets, controllers)

- **l10n/**: Localization files for multiple languages

## Guidelines

1. Each feature should be self-contained
2. Shared functionality goes in core/
3. Follow clean architecture principles
4. Use proper naming conventions
5. Keep feature-specific widgets in their feature folder
6. Only share truly common widgets in core/widgets 