# Structure de Répertoire

```terminal
app
├── lib
│   └── features
│       └── first_name
│           ├── application
│           │   └── use_cases
│           │       └── add_first_name.dart
│           ├── domain
│           │   ├── ports
│           │   │   └── first_name_port.dart
│           │   └── value_objects
│           │       └── first_name.dart
│           ├── infrastructure
│           │   └── first_name_adapter.dart
│           └── presentation
│               ├── bloc
│               │   ├── first_name_bloc.dart
│               │   ├── first_name_event.dart
│               │   └── first_name_state.dart
│               └── pages
│                   └── first_name_page.dart
└── test
    └── first_name
        ├── first_name_adapter_test.dart
        └── first_name_page_test.dart
```