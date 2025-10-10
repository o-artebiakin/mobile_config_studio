import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/config_flavor.dart';
import '../models/config_group.dart';
import '../models/config_key.dart';

part 'config_provider.freezed.dart';
part 'config_provider.g.dart';

/// Provider for the configuration state
final configProvider = StateNotifierProvider<ConfigNotifier, ConfigState>((ref) {
  return ConfigNotifier();
});

/// State class for configuration data
@freezed
class ConfigState with _$ConfigState {
  const ConfigState._();

  const factory ConfigState({
    required List<ConfigFlavor> flavors,
    required String selectedFlavorName,
    required String selectedGroupName,
  }) = _ConfigState;

  factory ConfigState.initial() {
    return const ConfigState(
      flavors: [],
      selectedFlavorName: '',
      selectedGroupName: '',
    );
  }

  ConfigFlavor? get selectedFlavor => flavors.isEmpty
      ? null
      : flavors.firstWhere(
          (f) => f.name == selectedFlavorName,
          orElse: () => flavors.first,
        );

  List<ConfigGroup> get groups => selectedFlavor?.groups ?? [];

  ConfigGroup? get selectedGroup => groups.isEmpty
      ? null
      : groups.firstWhere(
          (g) => g.name == selectedGroupName,
          orElse: () => groups.first,
        );

  List<ConfigKey> get selectedKeys => selectedGroup?.keys ?? [];

  /// Get selected keys sorted alphabetically by key name (case-insensitive)
  List<ConfigKey> get selectedKeysSorted {
    final keys = selectedKeys;
    return List<ConfigKey>.from(keys)
      ..sort((a, b) => a.key.toLowerCase().compareTo(b.key.toLowerCase()));
  }

  factory ConfigState.fromJson(Map<String, dynamic> json) =>
      _$ConfigStateFromJson(json);
  
  /// Custom toJson that only exports flavors
  Map<String, dynamic> toJsonExport() {
    return {
      'flavors': flavors.map((f) => f.toJson()).toList(),
    };
  }
}

/// StateNotifier for managing configuration state
class ConfigNotifier extends StateNotifier<ConfigState> {
  ConfigNotifier() : super(ConfigState.initial());

  // ===== Flavor Methods =====
  
  void selectFlavor(String flavorName) {
    if (state.flavors.any((f) => f.name == flavorName)) {
      final flavor = state.flavors.firstWhere((f) => f.name == flavorName);
      final newSelectedGroup = flavor.groups.isNotEmpty ? flavor.groups.first.name : '';
      
      state = state.copyWith(
        selectedFlavorName: flavorName,
        selectedGroupName: newSelectedGroup,
      );
    }
  }

  void addFlavor(String name) {
    if (!state.flavors.any((f) => f.name == name)) {
      final isFirstFlavor = state.flavors.isEmpty;
      final now = DateTime.now();
      state = state.copyWith(
        flavors: [...state.flavors, ConfigFlavor(name: name, createdAt: now, updatedAt: now)],
        selectedFlavorName: isFirstFlavor ? name : state.selectedFlavorName,
        selectedGroupName: isFirstFlavor ? '' : state.selectedGroupName,
      );
    }
  }

  void deleteFlavor(String name) {
    final newFlavors = state.flavors.where((f) => f.name != name).toList();
    final newSelectedFlavor = newFlavors.isEmpty
        ? ''
        : (state.selectedFlavorName == name
            ? newFlavors.first.name
            : state.selectedFlavorName);

    final newSelectedGroup = newFlavors.isEmpty
        ? ''
        : (state.selectedFlavorName == name && newFlavors.first.groups.isNotEmpty
            ? newFlavors.first.groups.first.name
            : state.selectedGroupName);

    state = state.copyWith(
      flavors: newFlavors,
      selectedFlavorName: newSelectedFlavor,
      selectedGroupName: newSelectedGroup,
    );
  }

  // ===== Group Methods =====

  void selectGroup(String groupName) {
    if (state.groups.any((g) => g.name == groupName)) {
      state = state.copyWith(selectedGroupName: groupName);
    }
  }

  void addGroup(String name) {
    final flavorIndex = state.flavors.indexWhere((f) => f.name == state.selectedFlavorName);
    if (flavorIndex == -1) return;

    final flavor = state.flavors[flavorIndex];
    if (flavor.groups.any((g) => g.name == name)) return;

    final isFirstGroup = flavor.groups.isEmpty;
    final now = DateTime.now();
    final updatedFlavors = [...state.flavors];
    updatedFlavors[flavorIndex] = flavor.copyWith(
      groups: [...flavor.groups, ConfigGroup(name: name, createdAt: now, updatedAt: now)],
      updatedAt: now,
    );

    state = state.copyWith(
      flavors: updatedFlavors,
      selectedGroupName: isFirstGroup ? name : state.selectedGroupName,
    );
  }

  void deleteGroup(String name) {
    final flavorIndex = state.flavors.indexWhere((f) => f.name == state.selectedFlavorName);
    if (flavorIndex == -1) return;

    final flavor = state.flavors[flavorIndex];
    final newGroups = flavor.groups.where((g) => g.name != name).toList();
    final newSelectedGroup = newGroups.isEmpty
        ? ''
        : (state.selectedGroupName == name
            ? newGroups.first.name
            : state.selectedGroupName);

    final updatedFlavors = [...state.flavors];
    updatedFlavors[flavorIndex] = flavor.copyWith(
      groups: newGroups,
      updatedAt: DateTime.now(),
    );

    state = state.copyWith(
      flavors: updatedFlavors,
      selectedGroupName: newSelectedGroup,
    );
  }

  // ===== Key Methods =====

  /// Add a new key with automatic timestamp creation
  void addKey(String groupName, String key, String value) {
    final flavorIndex = state.flavors.indexWhere((f) => f.name == state.selectedFlavorName);
    if (flavorIndex == -1) return;

    final flavor = state.flavors[flavorIndex];
    final groupIndex = flavor.groups.indexWhere((g) => g.name == groupName);
    if (groupIndex == -1) return;

    final now = DateTime.now();
    final configKey = ConfigKey(
      key: key,
      value: value,
      createdAt: now,
      updatedAt: now,
    );

    final group = flavor.groups[groupIndex];
    final updatedGroups = [...flavor.groups];
    updatedGroups[groupIndex] = group.copyWith(
      keys: [...group.keys, configKey],
      updatedAt: now,
    );

    final updatedFlavors = [...state.flavors];
    updatedFlavors[flavorIndex] = flavor.copyWith(
      groups: updatedGroups,
      updatedAt: now,
    );

    state = state.copyWith(
      flavors: updatedFlavors,
    );
  }

  /// Update an existing key, preserving createdAt and updating updatedAt
  void updateKey(String groupName, int keyIndex, String newKey, String newValue) {
    final flavorIndex = state.flavors.indexWhere((f) => f.name == state.selectedFlavorName);
    if (flavorIndex == -1) return;

    final flavor = state.flavors[flavorIndex];
    final groupIndex = flavor.groups.indexWhere((g) => g.name == groupName);
    if (groupIndex == -1) return;

    final group = flavor.groups[groupIndex];
    final oldKey = group.keys[keyIndex];
    final now = DateTime.now();
    final updatedKeys = [...group.keys];
    updatedKeys[keyIndex] = ConfigKey(
      key: newKey,
      value: newValue,
      createdAt: oldKey.createdAt,  // Preserve creation time
      updatedAt: now,     // Update modification time
    );

    final updatedGroups = [...flavor.groups];
    updatedGroups[groupIndex] = group.copyWith(
      keys: updatedKeys,
      updatedAt: now,
    );

    final updatedFlavors = [...state.flavors];
    updatedFlavors[flavorIndex] = flavor.copyWith(
      groups: updatedGroups,
      updatedAt: now,
    );

    state = state.copyWith(
      flavors: updatedFlavors,
    );
  }

  void deleteKey(String groupName, ConfigKey key) {
    final flavorIndex = state.flavors.indexWhere((f) => f.name == state.selectedFlavorName);
    if (flavorIndex == -1) return;

    final flavor = state.flavors[flavorIndex];
    final groupIndex = flavor.groups.indexWhere((g) => g.name == groupName);
    if (groupIndex == -1) return;

    final group = flavor.groups[groupIndex];
    final now = DateTime.now();
    final updatedGroups = [...flavor.groups];
    updatedGroups[groupIndex] = group.copyWith(
      keys: group.keys.where((k) => k != key).toList(),
      updatedAt: now,
    );

    final updatedFlavors = [...state.flavors];
    updatedFlavors[flavorIndex] = flavor.copyWith(
      groups: updatedGroups,
      updatedAt: now,
    );

    state = state.copyWith(
      flavors: updatedFlavors,
    );
  }

  // ===== Import/Export Methods =====

  void loadFromJson(Map<String, dynamic> json) {
    try {
      // Parse flavors from JSON
      final flavorsList = json['flavors'] as List<dynamic>? ?? [];
      final flavors = flavorsList
          .map((f) => ConfigFlavor.fromJson(f as Map<String, dynamic>))
          .toList();
      
      // Determine selected flavor and group
      final selectedFlavorName = json['selectedFlavorName'] as String? ?? 
          (flavors.isNotEmpty ? flavors.first.name : '');
      
      final selectedFlavor = flavors.isNotEmpty 
          ? flavors.firstWhere((f) => f.name == selectedFlavorName, orElse: () => flavors.first)
          : null;
          
      final selectedGroupName = json['selectedGroupName'] as String? ?? 
          (selectedFlavor != null && selectedFlavor.groups.isNotEmpty 
              ? selectedFlavor.groups.first.name 
              : '');
      
      // Update state - loading from file doesn't mark as unsaved
      state = ConfigState(
        flavors: flavors,
        selectedFlavorName: selectedFlavorName,
        selectedGroupName: selectedGroupName,
      );
    } catch (e) {
      debugPrint('Error loading config from JSON: $e');
    }
  }

  void reset() {
    state = ConfigState.initial();
  }
}
