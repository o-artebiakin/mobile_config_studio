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
    @Default(false) bool hasUnsavedChanges,
  }) = _ConfigState;

  factory ConfigState.initial() {
    return const ConfigState(
      flavors: [],
      selectedFlavorName: '',
      selectedGroupName: '',
      hasUnsavedChanges: false,
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
      state = state.copyWith(
        flavors: [...state.flavors, ConfigFlavor(name: name)],
        selectedFlavorName: isFirstFlavor ? name : state.selectedFlavorName,
        selectedGroupName: isFirstFlavor ? '' : state.selectedGroupName,
        hasUnsavedChanges: true,
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
      hasUnsavedChanges: true,
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
    final updatedFlavors = [...state.flavors];
    updatedFlavors[flavorIndex] = flavor.copyWith(
      groups: [...flavor.groups, ConfigGroup(name: name)],
    );

    state = state.copyWith(
      flavors: updatedFlavors,
      selectedGroupName: isFirstGroup ? name : state.selectedGroupName,
      hasUnsavedChanges: true,
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
    updatedFlavors[flavorIndex] = flavor.copyWith(groups: newGroups);

    state = state.copyWith(
      flavors: updatedFlavors,
      selectedGroupName: newSelectedGroup,
      hasUnsavedChanges: true,
    );
  }

  // ===== Key Methods =====

  void addKey(String groupName, ConfigKey key) {
    final flavorIndex = state.flavors.indexWhere((f) => f.name == state.selectedFlavorName);
    if (flavorIndex == -1) return;

    final flavor = state.flavors[flavorIndex];
    final groupIndex = flavor.groups.indexWhere((g) => g.name == groupName);
    if (groupIndex == -1) return;

    final group = flavor.groups[groupIndex];
    final updatedGroups = [...flavor.groups];
    updatedGroups[groupIndex] = group.copyWith(
      keys: [...group.keys, key],
    );

    final updatedFlavors = [...state.flavors];
    updatedFlavors[flavorIndex] = flavor.copyWith(groups: updatedGroups);

    state = state.copyWith(
      flavors: updatedFlavors,
      hasUnsavedChanges: true,
    );
  }

  void updateKey(String groupName, int keyIndex, ConfigKey updatedKey) {
    final flavorIndex = state.flavors.indexWhere((f) => f.name == state.selectedFlavorName);
    if (flavorIndex == -1) return;

    final flavor = state.flavors[flavorIndex];
    final groupIndex = flavor.groups.indexWhere((g) => g.name == groupName);
    if (groupIndex == -1) return;

    final group = flavor.groups[groupIndex];
    final updatedKeys = [...group.keys];
    updatedKeys[keyIndex] = updatedKey;

    final updatedGroups = [...flavor.groups];
    updatedGroups[groupIndex] = group.copyWith(keys: updatedKeys);

    final updatedFlavors = [...state.flavors];
    updatedFlavors[flavorIndex] = flavor.copyWith(groups: updatedGroups);

    state = state.copyWith(
      flavors: updatedFlavors,
      hasUnsavedChanges: true,
    );
  }

  void deleteKey(String groupName, ConfigKey key) {
    final flavorIndex = state.flavors.indexWhere((f) => f.name == state.selectedFlavorName);
    if (flavorIndex == -1) return;

    final flavor = state.flavors[flavorIndex];
    final groupIndex = flavor.groups.indexWhere((g) => g.name == groupName);
    if (groupIndex == -1) return;

    final group = flavor.groups[groupIndex];
    final updatedGroups = [...flavor.groups];
    updatedGroups[groupIndex] = group.copyWith(
      keys: group.keys.where((k) => k != key).toList(),
    );

    final updatedFlavors = [...state.flavors];
    updatedFlavors[flavorIndex] = flavor.copyWith(groups: updatedGroups);

    state = state.copyWith(
      flavors: updatedFlavors,
      hasUnsavedChanges: true,
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
        hasUnsavedChanges: false,
      );
    } catch (e) {
      debugPrint('Error loading config from JSON: $e');
    }
  }

  void markAsSaved() {
    state = state.copyWith(hasUnsavedChanges: false);
  }

  void reset() {
    state = ConfigState.initial();
  }
}
