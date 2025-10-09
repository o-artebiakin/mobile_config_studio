import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_config_studio/models/config_flavor.dart';
import 'package:mobile_config_studio/models/config_group.dart';
import 'package:mobile_config_studio/models/config_key.dart';
import 'package:mobile_config_studio/providers/config_provider.dart';
import 'package:mobile_config_studio/services/config_export_service.dart';

void main() {
  group('ConfigExportService', () {
    late ConfigExportService service;
    late ConfigState testState;

    setUp(() {
      service = ConfigExportService();
      testState = ConfigState(
        flavors: [
          ConfigFlavor(
            name: 'Development',
            groups: [
              ConfigGroup(
                name: 'General',
                keys: [
                  const ConfigKey(key: 'app_name', value: 'Test App'),
                  const ConfigKey(key: 'version', value: '1.0.0'),
                ],
              ),
            ],
          ),
        ],
        selectedFlavorName: 'Development',
        selectedGroupName: 'General',
        hasUnsavedChanges: false,
      );
    });

    test('toJson returns correct structure', () {
      final json = service.toJson(testState);

      expect(json, isA<Map<String, dynamic>>());
      expect(json['flavors'], isA<List>());
      expect((json['flavors'] as List).length, 1);
    });

    test('toJsonString returns valid JSON', () {
      final jsonString = service.toJsonString(testState);

      expect(() => jsonDecode(jsonString), returnsNormally);
    });

    test('toJsonString with pretty formatting', () {
      final jsonString = service.toJsonString(testState, pretty: true);

      expect(jsonString, contains('\n'));
      expect(jsonString, contains('  '));
    });

    test('toBase64 returns valid base64', () {
      final base64String = service.toBase64(testState);

      expect(base64String, isNotEmpty);
      expect(() => base64Decode(base64String), returnsNormally);
    });

    test('toBase64 roundtrip preserves data', () {
      final base64String = service.toBase64(testState);
      final decoded = utf8.decode(base64Decode(base64String));
      final json = jsonDecode(decoded);

      expect(json['flavors'], isA<List>());
      expect((json['flavors'] as List).length, 1);
    });

    test('toShareUrl generates correct URL', () {
      final url = service.toShareUrl(
        testState,
        baseUrl: 'https://example.com',
      );

      expect(url, startsWith('https://example.com?config='));
      expect(url.length, greaterThan('https://example.com?config='.length));
    });

    test('toFlutterCommand generates basic command', () {
      final command = service.toFlutterCommand(testState);

      expect(command, startsWith('flutter run'));
      expect(command, contains('--dart-define=CONFIG_DATA='));
    });

    test('toFlutterCommand with target', () {
      final command = service.toFlutterCommand(
        testState,
        target: 'chrome',
      );

      expect(command, contains('-d chrome'));
    });

    test('toFlutterCommand with flavor', () {
      final command = service.toFlutterCommand(
        testState,
        flavor: 'production',
      );

      expect(command, contains('--flavor production'));
    });

    test('toFlutterCommand with target and flavor', () {
      final command = service.toFlutterCommand(
        testState,
        target: 'ios',
        flavor: 'staging',
      );

      expect(command, contains('-d ios'));
      expect(command, contains('--flavor staging'));
      expect(command, contains('--dart-define=CONFIG_DATA='));
    });
  });
}
