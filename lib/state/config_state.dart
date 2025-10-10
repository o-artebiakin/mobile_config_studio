import 'package:flutter/material.dart';

import '../models/config_group.dart';
import '../models/config_key.dart';

class ConfigState extends ChangeNotifier {
  final List<ConfigGroup> _groups = [
    ConfigGroup(
      name: 'General',
      keys: [
        ConfigKey(
          key: 'app_name',
          value: 'My App',
          createdAt: DateTime(2024),
          updatedAt: DateTime(2024),
        ),
        ConfigKey(
          key: 'version',
          value: '1.0.0',
          createdAt: DateTime(2024),
          updatedAt: DateTime(2024),
        ),
      ],
      createdAt: DateTime(2024),
      updatedAt: DateTime(2024),
    ),
    ConfigGroup(
      name: 'Network',
      keys: [
        ConfigKey(
          key: 'api_url',
          value: 'https://api.example.com',
          createdAt: DateTime(2024),
          updatedAt: DateTime(2024),
        ),
        ConfigKey(
          key: 'timeout',
          value: '30',
          createdAt: DateTime(2024),
          updatedAt: DateTime(2024),
        ),
      ],
      createdAt: DateTime(2024),
      updatedAt: DateTime(2024),
    ),
    ConfigGroup(
      name: 'Flags',
      keys: [
        ConfigKey(
          key: 'enable_logging',
          value: 'true',
          createdAt: DateTime(2024),
          updatedAt: DateTime(2024),
        ),
        ConfigKey(
          key: 'debug_mode',
          value: 'false',
          createdAt: DateTime(2024),
          updatedAt: DateTime(2024),
        ),
      ],
      createdAt: DateTime(2024),
      updatedAt: DateTime(2024),
    ),
  ];

  String _selectedGroupName = 'General';

  List<ConfigGroup> get groups => List.unmodifiable(_groups);

  String get selectedGroupName => _selectedGroupName;

  ConfigGroup get selectedGroup =>
      _groups.firstWhere((g) => g.name == _selectedGroupName);

  List<ConfigKey> get selectedKeys => selectedGroup.keys;

  void selectGroup(String groupName) {
    if (_groups.any((g) => g.name == groupName)) {
      _selectedGroupName = groupName;
      notifyListeners();
    }
  }

  void addGroup(String name) {
    if (!_groups.any((g) => g.name == name)) {
      final now = DateTime.now();
      _groups.add(ConfigGroup(
        name: name,
        createdAt: now,
        updatedAt: now,
      ));
      notifyListeners();
    }
  }

  void deleteGroup(String name) {
    if (_groups.length > 1) {
      _groups.removeWhere((g) => g.name == name);
      if (_selectedGroupName == name) {
        _selectedGroupName = _groups.first.name;
      }
      notifyListeners();
    }
  }

  void addKey(String groupName, ConfigKey key) {
    final groupIndex = _groups.indexWhere((g) => g.name == groupName);
    if (groupIndex != -1) {
      final group = _groups[groupIndex];
      _groups[groupIndex] = group.copyWith(
        keys: [...group.keys, key],
      );
      notifyListeners();
    }
  }

  void updateKey(String groupName, int keyIndex, ConfigKey updatedKey) {
    final groupIndex = _groups.indexWhere((g) => g.name == groupName);
    if (groupIndex != -1) {
      final group = _groups[groupIndex];
      final updatedKeys = [...group.keys];
      updatedKeys[keyIndex] = updatedKey;
      _groups[groupIndex] = group.copyWith(keys: updatedKeys);
      notifyListeners();
    }
  }

  void deleteKey(String groupName, ConfigKey key) {
    final groupIndex = _groups.indexWhere((g) => g.name == groupName);
    if (groupIndex != -1) {
      final group = _groups[groupIndex];
      _groups[groupIndex] = group.copyWith(
        keys: group.keys.where((k) => k != key).toList(),
      );
      notifyListeners();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'groups': _groups.map((g) => g.toJson()).toList(),
    };
  }

  void loadFromJson(Map<String, dynamic> json) {
    _groups.clear();
    final groupsList = json['groups'] as List<dynamic>;
    _groups.addAll(
      groupsList.map((g) => ConfigGroup.fromJson(g as Map<String, dynamic>)),
    );
    if (_groups.isNotEmpty) {
      _selectedGroupName = _groups.first.name;
    }
    notifyListeners();
  }

  void reset() {
    final defaultDate = DateTime(2024);
    _groups.clear();
    _groups.addAll([
      ConfigGroup(
        name: 'General',
        keys: [
          ConfigKey(
            key: 'app_name',
            value: 'My App',
            createdAt: defaultDate,
            updatedAt: defaultDate,
          ),
          ConfigKey(
            key: 'version',
            value: '1.0.0',
            createdAt: defaultDate,
            updatedAt: defaultDate,
          ),
        ],
        createdAt: defaultDate,
        updatedAt: defaultDate,
      ),
      ConfigGroup(
        name: 'Network',
        keys: [
          ConfigKey(
            key: 'api_url',
            value: 'https://api.example.com',
            createdAt: defaultDate,
            updatedAt: defaultDate,
          ),
          ConfigKey(
            key: 'timeout',
            value: '30',
            createdAt: defaultDate,
            updatedAt: defaultDate,
          ),
        ],
        createdAt: defaultDate,
        updatedAt: defaultDate,
      ),
      ConfigGroup(
        name: 'Flags',
        keys: [
          ConfigKey(
            key: 'enable_logging',
            value: 'true',
            createdAt: defaultDate,
            updatedAt: defaultDate,
          ),
          ConfigKey(
            key: 'debug_mode',
            value: 'false',
            createdAt: defaultDate,
            updatedAt: defaultDate,
          ),
        ],
        createdAt: defaultDate,
        updatedAt: defaultDate,
      ),
    ]);
    _selectedGroupName = 'General';
    notifyListeners();
  }
}
