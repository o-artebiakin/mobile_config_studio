import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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
    required List<ConfigGroup> groups,
    required String selectedGroupName,
  }) = _ConfigState;

  factory ConfigState.initial() {
    return const ConfigState(
      groups: [],
      selectedGroupName: '',
    );
  }

  ConfigGroup? get selectedGroup => groups.isEmpty
      ? null
      : groups.firstWhere(
          (g) => g.name == selectedGroupName,
          orElse: () => groups.first,
        );

  List<ConfigKey> get selectedKeys => selectedGroup?.keys ?? [];

  factory ConfigState.fromJson(Map<String, dynamic> json) =>
      _$ConfigStateFromJson(json);
  
  /// Custom toJson that only exports groups (not selectedGroupName)
  Map<String, dynamic> toJsonExport() {
    return {
      'groups': groups.map((g) => g.toJson()).toList(),
    };
  }
}

/// StateNotifier for managing configuration state
class ConfigNotifier extends StateNotifier<ConfigState> {
  ConfigNotifier() : super(ConfigState.initial());

  void selectGroup(String groupName) {
    if (state.groups.any((g) => g.name == groupName)) {
      state = state.copyWith(selectedGroupName: groupName);
    }
  }

  void addGroup(String name) {
    if (!state.groups.any((g) => g.name == name)) {
      final isFirstGroup = state.groups.isEmpty;
      state = state.copyWith(
        groups: [...state.groups, ConfigGroup(name: name)],
        selectedGroupName: isFirstGroup ? name : state.selectedGroupName,
      );
    }
  }

  void deleteGroup(String name) {
    final newGroups = state.groups.where((g) => g.name != name).toList();
    final newSelectedGroup = newGroups.isEmpty
        ? ''
        : (state.selectedGroupName == name
            ? newGroups.first.name
            : state.selectedGroupName);

    state = state.copyWith(
      groups: newGroups,
      selectedGroupName: newSelectedGroup,
    );
  }

  void addKey(String groupName, ConfigKey key) {
    final groupIndex = state.groups.indexWhere((g) => g.name == groupName);
    if (groupIndex != -1) {
      final group = state.groups[groupIndex];
      final updatedGroups = [...state.groups];
      updatedGroups[groupIndex] = group.copyWith(
        keys: [...group.keys, key],
      );
      state = state.copyWith(groups: updatedGroups);
    }
  }

  void updateKey(String groupName, int keyIndex, ConfigKey updatedKey) {
    final groupIndex = state.groups.indexWhere((g) => g.name == groupName);
    if (groupIndex != -1) {
      final group = state.groups[groupIndex];
      final updatedKeys = [...group.keys];
      updatedKeys[keyIndex] = updatedKey;
      
      final updatedGroups = [...state.groups];
      updatedGroups[groupIndex] = group.copyWith(keys: updatedKeys);
      
      state = state.copyWith(groups: updatedGroups);
    }
  }

  void deleteKey(String groupName, ConfigKey key) {
    final groupIndex = state.groups.indexWhere((g) => g.name == groupName);
    if (groupIndex != -1) {
      final group = state.groups[groupIndex];
      final updatedGroups = [...state.groups];
      updatedGroups[groupIndex] = group.copyWith(
        keys: group.keys.where((k) => k != key).toList(),
      );
      state = state.copyWith(groups: updatedGroups);
    }
  }

  void loadFromJson(Map<String, dynamic> json) {
    try {
      // Parse groups from JSON
      final groupsList = json['groups'] as List<dynamic>? ?? [];
      final groups = groupsList
          .map((g) => ConfigGroup.fromJson(g as Map<String, dynamic>))
          .toList();
      
      // Determine selected group name
      final selectedGroupName = json['selectedGroupName'] as String? ?? 
          (groups.isNotEmpty ? groups.first.name : '');
      
      // Update state
      state = ConfigState(
        groups: groups,
        selectedGroupName: selectedGroupName,
      );
    } catch (e) {
      debugPrint('Error loading from JSON: $e');
      rethrow;
    }
  }

  void reset() {
    state = ConfigState.initial();
  }
}
