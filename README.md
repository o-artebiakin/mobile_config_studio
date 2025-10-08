# Mobile Config Studio# Mobile Config Studio# Mobile Config Studio# mobile_config_studio



> **⚠️ Beta Release v0.0.1** - Early preview version for demonstration purposes only.



A modern, cross-platform configuration management tool built with Flutter. Create, edit, and share application configurations through an intuitive web interface.> **⚠️ Beta Release v0.0.1** - This is a beta version for testing and feedback. Configurations are not persisted across sessions.



🌐 **[Try it now - Live Web App](https://o-artebiakin.github.io/mobile_config_studio/)**



## ✨ Stable Features (v0.0.1)A modern, cross-platform configuration management tool built with Flutter. Create, edit, and share application configurations through an intuitive web interface.A modern, cross-platform configuration management tool built with Flutter. Create, edit, and share application configurations through an intuitive web interface.A modern Flutter configuration studio with Material Design 3, built with best practices.



### ✅ Working & Demonstrated

- 🎨 **View Configurations** - Display configuration data in a clean Material Design 3 interface

- 🔗 **Import from URL** - Load configurations from base64-encoded URL parameters🌐 **[Try it now - Live Web App](https://o-artebiakin.github.io/mobile_config_studio/)**

- 📱 **Responsive Layout** - Works across different screen sizes



### ⚠️ Experimental (May Be Broken)

The following features are visible in the UI but may not work correctly in this beta:## ✨ Features🌐 **[Try it now - Live Web App](https://o-artebiakin.github.io/mobile_config_studio/)**## Features

- ❌ Create/Edit/Delete operations (not persisted)

- ❌ Export configurations

- ❌ Manual import via dialog

- ❌ Data persistence (all data lost on refresh)- 🎨 **Modern UI** - Clean Material Design 3 interface



> These experimental features will be stabilized in future releases.- 📦 **Configuration Groups** - Organize settings into logical groups



## 🚀 Quick Start- 🔗 **URL Sharing** - Share configurations via base64-encoded URLs## ✨ Features- 🎨 Material Design 3 UI



### Try the Demo- 📤 **Import/Export** - Easy configuration transfer



**Option 1: Visit with sample data**- 🌐 **Cross-platform** - Web, Android, iOS, macOS, Windows- 📦 Riverpod state management

```

https://o-artebiakin.github.io/mobile_config_studio/?config=eyJncm91cHMiOlt7Im5hbWUiOiJHZW5lcmFsIiwia2V5cyI6W3sia2V5IjoiYXBwX25hbWUiLCJ2YWx1ZSI6Ik15IEFwcCJ9LHsia2V5IjoidmVyc2lvbiIsInZhbHVlIjoiMS4wLjAifV19LHsibmFtZSI6Ik5ldHdvcmsiLCJrZXlzIjpbeyJrZXkiOiJhcGlfdXJsIiwidmFsdWUiOiJodHRwczovL2FwaS5leGFtcGxlLmNvbSJ9LHsia2V5IjoidGltZW91dCIsInZhbHVlIjoiMzAifV19XX0=- ⚠️ **Beta Limitation** - No persistence yet (data lost on refresh)

```

- 🎨 **Modern UI** - Clean Material Design 3 interface- 🧊 Freezed immutable data classes

**Option 2: Create your own URL**

1. Create a JSON configuration:## 🚀 Quick Start

   ```json

   {- 📦 **Configuration Groups** - Organize settings into logical groups- 🔄 JSON serialization

     "groups": [

       {### Web App

         "name": "General",

         "keys": [- 🔗 **URL Sharing** - Share configurations via base64-encoded URLs- 🪝 Flutter Hooks for UI logic

           {"key": "app_name", "value": "My App"},

           {"key": "version", "value": "1.0.0"}Simply visit: [https://o-artebiakin.github.io/mobile_config_studio/](https://o-artebiakin.github.io/mobile_config_studio/)

         ]

       }- 📤 **Import/Export** - Easy configuration transfer- �️ go_router for navigation & deep links

     ]

   }### Local Development

   ```

- 🌐 **Cross-platform** - Web, Android, iOS, macOS, Windows- �🔗 URL-based config import/export

2. Encode to base64:

   ```bash1. **Install Flutter** (if not already installed):

   echo -n '{"groups":[{"name":"General","keys":[{"key":"app_name","value":"My App"}]}]}' | base64

   ```   ```bash- 💾 **No Backend** - All data stored locally or shared via URL- 📤 Share configurations via URL



3. Open URL:   # Visit https://flutter.dev/docs/get-started/install

   ```

   https://o-artebiakin.github.io/mobile_config_studio/?config=<your_base64_here>   ```- 📱 Mobile deep link support (iOS & Android)

   ```



### Local Development

2. **Clone and setup**:## 🚀 Quick Start

1. **Install Flutter** (if not already installed):

   ```bash   ```bash

   # Visit https://flutter.dev/docs/get-started/install

   ```   git clone <repository-url>## Web App



2. **Clone and setup**:   cd mobile_config_studio

   ```bash

   git clone <repository-url>   flutter pub get### Web App

   cd mobile_config_studio

   flutter pub get   ```

   ```

🌐 [Open Web App](https://o-artebiakin.github.io/mobile_config_studio/)

3. **Generate code** (Freezed & JSON serialization):

   ```bash3. **Generate code** (Freezed & JSON serialization):

   flutter pub run build_runner build --delete-conflicting-outputs

   ```   ```bashSimply visit: [https://o-artebiakin.github.io/mobile_config_studio/](https://o-artebiakin.github.io/mobile_config_studio/)



4. **Run the app**:   flutter pub run build_runner build --delete-conflicting-outputs

   ```bash

   # Web   ```## Import/Export Configurations

   flutter run -d chrome

   

   # macOS

   flutter run -d macos4. **Run the app**:### Local Development

   ```

   ```bash

## 📖 How to Use (Beta v0.0.1)

   # Web### Share via URL

### ✅ Viewing Configurations (Stable)

   flutter run -d chrome

1. Open the app with a `config` URL parameter

2. The configuration will be automatically loaded and displayed   1. **Install Flutter** (if not already installed):

3. Browse groups in the sidebar

4. View key-value pairs in the main panel   # macOS



### ⚠️ Editing Features (Experimental)   flutter run -d macos   ```bash1. **Create your configuration** in the app



The UI shows editing features (Add Group, Add Key, Edit, Delete) but these are **not fully functional** in v0.0.1:   

- Changes are not persisted

- May cause unexpected behavior   # Other platforms   # Visit https://flutter.dev/docs/get-started/install2. **Click Export** (download icon in AppBar)

- For demonstration/UI preview only

   flutter run

> **Recommendation:** Use this beta only for viewing configurations via URL import.

   ```   ```3. **Copy the share URL** - contains your config as base64 parameter

## 🏗️ Build for Production



### Web (PWA with offline support)

## 📖 How to Use4. **Share the URL** - anyone can open it to load your configuration

```bash

flutter build web --release --pwa-strategy=offline-first

```

### Creating Configurations2. **Clone and setup**:

For GitHub Pages deployment:

```bash

flutter build web --release --pwa-strategy=offline-first -o docs --base-href /mobile_config_studio/

```1. **Add a Group** - Click the `+` button in the sidebar   ```bash### Import from URL



### Mobile & Desktop2. **Add Keys** - Within a group, click "Add Key" to create configuration entries



```bash3. **Edit Values** - Click any key/value to modify it   git clone <repository-url>

# Android

flutter build apk --release4. **Delete Items** - Use the delete icon to remove keys or groups



# iOS   cd mobile_config_studioSimply open a URL with a `config` parameter:

flutter build ios --release

> **⚠️ Beta Note:** Changes are not saved! Use Export to preserve your work.

# macOS

flutter build macos --release   flutter pub get



# Windows### Sharing Configurations

flutter build windows --release

```   ``````



## 🛠️ Technology Stack#### Export & Share



- **Flutter** ^3.9.2 - UI frameworkhttps://your-app.com/?config=<base64_encoded_json>

- **Riverpod** 2.6.1 - State management

- **go_router** 14.6.2 - Navigation & deep linking1. Click the **Export** button (download icon) in the toolbar

- **Freezed** 2.5.7 - Immutable data models

- **JSON Serializable** 6.8.0 - JSON serialization2. Choose **"Copy Share URL"** to get a shareable link3. **Generate code** (Freezed & JSON serialization):```

- **Flutter Hooks** 0.20.5 - Widget lifecycle management

3. Share the URL with others - it contains your full configuration

## 📁 Project Structure

   ```bash

```

lib/#### Import from URL

├── main.dart              # App entry point

├── models/                # Data models (Freezed)   flutter pub run build_runner build --delete-conflicting-outputsThe app will automatically parse and load the configuration on startup.

│   ├── config_key.dart

│   └── config_group.dartSimply open a URL with a `config` parameter:

├── providers/             # State management (Riverpod)

│   └── config_provider.dart```   ```

├── router/                # Navigation (go_router)

│   └── app_router.darthttps://o-artebiakin.github.io/mobile_config_studio/?config=<base64_encoded_config>

├── screens/               # App screens

│   └── home_screen.dart```### Manual Import

├── services/              # Business logic

│   └── config_actions.dart

└── widgets/               # Reusable components

    └── ...The app automatically loads the configuration from the URL.4. **Run the app**:

```



## 🧪 Testing

#### Manual Import   ```bash1. **Click Import** (upload icon in AppBar)

Run tests:

```bash

flutter test

```1. Click the **Import** button (upload icon)   # Web2. **Paste base64 encoded configuration**



Run with coverage:2. Paste the base64-encoded configuration

```bash

flutter test --coverage3. Click **Import** to load   flutter run -d chrome3. **Click Import** - configuration will be loaded

```



## 📝 Beta v0.0.1 Scope

## 🏗️ Build for Production   

### ✅ What Works

- ✅ Import configurations from URL parameters

- ✅ Display configurations in groups

- ✅ View key-value pairs### Web (PWA with offline support)   # macOS### Example URL Format

- ✅ Responsive Material Design 3 UI

- ✅ Cross-platform builds



### ❌ Known Limitations```bash   flutter run -d macos

- ❌ No data persistence (refresh loses data)

- ❌ Create/Edit/Delete operations not functionalflutter build web --release --pwa-strategy=offline-first

- ❌ Export feature not working

- ❌ Manual import dialog not functional```   ```

- ❌ No dark mode

- ❌ No validation



### 🎯 Roadmap to v1.0.0For GitHub Pages deployment:   # Other platformshttps://o-artebiakin.github.io/mobile_config_studio/?config=eyJncm91cHMiOlt7Im5hbWUiOiJHZW5lcmFsIiwia2V5cyI6W3sia2V5IjoiYXBwX25hbWUiLCJ2YWx1ZSI6Ik15IEFwcCJ9XX1dfQ==



**v0.1.0 (Next Release)**```bash

- [ ] Fix all CRUD operations (Create, Read, Update, Delete)

- [ ] Implement export functionalityflutter build web --release --pwa-strategy=offline-first -o docs --base-href /mobile_config_studio/   flutter run```

- [ ] Add local storage persistence

- [ ] Fix manual import dialog```



**v1.0.0 (Stable Release)**   ```

- [ ] Full data persistence

- [ ] Configuration validation### Mobile & Desktop

- [ ] Dark mode support

- [ ] Improved error handling## Getting Started

- [ ] Undo/redo functionality

- [ ] Configuration templates```bash



## 📝 License# Android## 📖 How to Use



This project is open source and available under the [MIT License](LICENSE).flutter build apk --release



## 🤝 Contributing### 1. Install Dependencies



Contributions are welcome! This is an early beta, so feedback is especially valuable.# iOS



## 🐛 Issues & Feedbackflutter build ios --release### Creating Configurations



Found a bug or have a feature request? Please [open an issue](../../issues).



**For this beta, we're interested in:**# macOS```bash

- Feedback on the URL import feature

- UI/UX suggestionsflutter build macos --release

- Bug reports (especially for the stable features)

- Feature priorities for v1.0.01. **Add a Group** - Click the `+` button in the sidebarflutter pub get



## ⚠️ Beta Disclaimer# Windows



This is version 0.0.1 - an early beta release for demonstration purposes. Many features are incomplete or non-functional. flutter build windows --release2. **Add Keys** - Within a group, click "Add Key" to create configuration entries```



**Use only for:**```

- ✅ Viewing configurations via URL import

- ✅ Testing the UI/UX concept3. **Edit Values** - Click any key/value to modify it

- ✅ Providing feedback

## 🛠️ Technology Stack

**Not suitable for:**

- ❌ Production use4. **Delete Items** - Use the delete icon to remove keys or groups### 2. Generate Code (Freezed & JSON Serialization)

- ❌ Data storage

- ❌ Critical configurations- **Flutter** ^3.9.2 - UI framework



---- **Riverpod** 2.6.1 - State management



Built with ❤️ using Flutter | **Beta v0.0.1** | [Changelog](CHANGELOG.md)- **go_router** 14.6.2 - Navigation & deep linking


- **Freezed** 2.5.7 - Immutable data models### Sharing Configurations```bash

- **JSON Serializable** 6.8.0 - JSON serialization

- **Flutter Hooks** 0.20.5 - Widget lifecycle managementflutter pub run build_runner build --delete-conflicting-outputs



## 📁 Project Structure#### Export & Share```



```

lib/

├── main.dart              # App entry point1. Click the **Export** button (download icon) in the toolbarOr for continuous generation during development:

├── models/                # Data models (Freezed)

│   ├── config_key.dart2. Choose **"Copy Share URL"** to get a shareable link

│   └── config_group.dart

├── providers/             # State management (Riverpod)3. Share the URL with others - it contains your full configuration```bash

│   └── config_provider.dart

├── router/                # Navigation (go_router)flutter pub run build_runner watch --delete-conflicting-outputs

│   └── app_router.dart

├── screens/               # App screens#### Import from URL```

│   └── home_screen.dart

├── services/              # Business logic

│   └── config_actions.dart

└── widgets/               # Reusable componentsSimply open a URL with a `config` parameter:### 3. Run the App

    └── ...

``````



## 🧪 Testinghttps://o-artebiakin.github.io/mobile_config_studio/?config=<base64_encoded_config>```bash



Run tests:```flutter run

```bash

flutter test```

```

The app automatically loads the configuration from the URL.

Run with coverage:

```bash## Build Details

flutter test --coverage

```#### Manual Import



## 🐛 Beta Limitations & Known Issues### Web Build (PWA)



This is a beta release with the following limitations:1. Click the **Import** button (upload icon)



- **No Persistence** - Configurations are lost on page refresh/reload2. Paste the base64-encoded configurationTo build the web version with PWA offline-first strategy:

- **No Dark Mode** - Light theme only

- **Basic Validation** - Limited input validation3. Click **Import** to load

- **No Undo/Redo** - Cannot undo accidental deletions

```bash

These will be addressed in future releases. Please report any issues!

## 🏗️ Build for Production flutter build web --release --pwa-strategy=offline-first -o docs --base-href /mobile_config_studio/

## 📝 Roadmap to v1.0.0

```

- [ ] Add local storage persistence

- [ ] Implement dark mode### Web (PWA with offline support)

- [ ] Add configuration validation

- [ ] Improve error handling### Other Platforms

- [ ] Add undo/redo functionality

- [ ] Add configuration templates```bash



## 📝 Licenseflutter build web --release --pwa-strategy=offline-first```bash



This project is open source and available under the [MIT License](LICENSE).```# Android



## 🤝 Contributingflutter build apk



Contributions are welcome! This is a beta release, so feedback and bug reports are especially valuable.For GitHub Pages deployment:



## 🐛 Issues & Feedback```bash# iOS



Found a bug or have a feature request? Please [open an issue](../../issues).flutter build web --release --pwa-strategy=offline-first -o docs --base-href /mobile_config_studio/flutter build ios



For this beta release, we're especially interested in:```

- Usability feedback

- Bug reports# macOS

- Feature requests for v1.0.0

### Mobile & Desktopflutter build macos

---



Built with ❤️ using Flutter | **Beta v0.0.1**

```bash# Windows

# Androidflutter build windows

flutter build apk --release```



# iOS## Architecture

flutter build ios --release

This project follows clean architecture principles:

# macOS

flutter build macos --release```

lib/

# Windows├── main.dart                 # App entry point with ProviderScope

flutter build windows --release├── models/                   # Freezed data models

```│   ├── config_key.dart

│   └── config_group.dart

## 🛠️ Technology Stack├── providers/                # Riverpod state management

│   └── config_provider.dart

- **Flutter** ^3.9.2 - UI framework├── screens/                  # App screens

- **Riverpod** 2.6.1 - State management│   └── home_screen.dart

- **go_router** 14.6.2 - Navigation & deep linking├── widgets/                  # Reusable widgets

- **Freezed** 2.5.7 - Immutable data models│   └── ...

- **JSON Serializable** 6.8.0 - JSON serialization└── services/                 # Business logic

- **Flutter Hooks** 0.20.5 - Widget lifecycle management    └── config_actions.dart

```

## 📁 Project Structure

## Code Generation

```

lib/This project uses `freezed` and `json_serializable` for code generation. See [FREEZED_GUIDE.md](FREEZED_GUIDE.md) for detailed information about:

├── main.dart              # App entry point

├── models/                # Data models (Freezed)- Creating freezed models

│   ├── config_key.dart- Running build_runner

│   └── config_group.dart- Best practices

├── providers/             # State management (Riverpod)- Troubleshooting

│   └── config_provider.dart

├── router/                # Navigation (go_router)## Deep Linking & Routing

│   └── app_router.dart

├── screens/               # App screensThis project uses `go_router` for navigation and deep link handling. See [GO_ROUTER_GUIDE.md](GO_ROUTER_GUIDE.md) for:

│   └── home_screen.dart

├── services/              # Business logic- go_router setup and configuration

│   └── config_actions.dart- Deep link implementation (web + mobile)

└── widgets/               # Reusable components- iOS and Android configuration

    └── ...- URL generation and navigation

```- Testing deep links



## 🧪 Testing## Technologies



Run tests:- **Flutter** ^3.9.2

```bash- **Riverpod** 2.6.1 - State management

flutter test- **go_router** 14.6.2 - Navigation & deep links

```- **Freezed** 2.5.7 - Immutable data classes

- **JSON Serializable** 6.8.0 - JSON serialization

Run with coverage:- **Flutter Hooks** 0.20.5 - Widget lifecycle hooks

```bash

flutter test --coverage## License

```

This project is open source and available under the MIT License.

## 📝 License


This project is open source and available under the [MIT License](LICENSE).

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 🐛 Issues

Found a bug or have a feature request? Please [open an issue](../../issues).

---

Built with ❤️ using Flutter
