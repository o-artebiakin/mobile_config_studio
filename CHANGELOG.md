# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.0.1] - 2024-10-08

### 🚀 Early Beta Release - Demo/Preview Only

This is an early beta release for demonstration and UI/UX feedback. Only core viewing features are stable.

#### ✅ Stable Features (Working)
- Import configurations from URL parameters (base64 encoding)
- Display configurations in groups and key-value pairs
- Modern Material Design 3 UI
- Responsive layout for different screen sizes
- Cross-platform support (Web, Android, iOS, macOS, Windows)
- PWA support with offline-first strategy

#### ⚠️ Experimental Features (May Be Broken)
These features are visible in the UI but not fully functional:
- Create/Edit/Delete operations (not persisted, may fail)
- Export configurations (UI present but may not work)
- Manual import dialog (visible but may not work)
- Data persistence (all changes lost on refresh)

#### Technical Stack
- Flutter ^3.9.2
- flutter_riverpod ^2.6.1
- go_router ^14.6.2
- freezed ^2.5.7
- json_serializable ^6.8.0
- flutter_hooks ^0.20.5

#### Documentation
- README with clear beta scope and limitations
- Build instructions for all platforms
- Development setup guide
- MIT License
- Release checklist

#### Known Limitations (v0.0.1)
- ❌ No local storage persistence (all data lost on refresh)
- ❌ CRUD operations not functional
- ❌ Export feature not working
- ❌ Manual import not working
- ❌ No dark mode support
- ❌ No configuration validation
- ❌ Limited error handling

#### Purpose
This release is for:
- ✅ Demonstrating the URL import feature
- ✅ Showcasing the UI/UX design
- ✅ Gathering early feedback
- ❌ NOT for production use

---

## Future Roadmap

### Planned for v0.1.0 (Next Release)
- [ ] Fix all CRUD operations (Create, Read, Update, Delete)
- [ ] Implement working export functionality
- [ ] Fix manual import dialog
- [ ] Add basic local storage persistence
- [ ] Improve error handling

### Planned for v1.0.0 (Stable Release)
- [ ] Full data persistence
- [ ] Configuration validation
- [ ] Dark mode support
- [ ] Undo/redo functionality
- [ ] Enhanced error messages
- [ ] User preferences

### Future Features (v1.1.0+)
- [ ] Configuration templates
- [ ] Multi-language support
- [ ] Export to different formats (YAML, TOML, etc.)
- [ ] Import from different formats
- [ ] Configuration history/versioning
- [ ] Search and filter functionality
- [ ] Bulk operations
- [ ] Configuration diff/compare
