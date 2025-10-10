import 'package:flutter_test/flutter_test.dart';

import 'package:mobile_config_studio/models/config_flavor.dart';
import 'package:mobile_config_studio/models/config_group.dart';
import 'package:mobile_config_studio/models/config_key.dart';
import 'package:mobile_config_studio/providers/config_provider.dart';
import 'package:mobile_config_studio/services/generators/command_line_generator.dart';

void main() {
  group('CommandLineGenerator', () {
    late CommandLineGenerator generator;
    late ConfigState testState;

    setUp(() {
      generator = CommandLineGenerator();
      final now = DateTime.now();
      
      testState = ConfigState(
        flavors: [
          ConfigFlavor(
            name: 'Development',
            groups: [
              ConfigGroup(
                name: 'Auth0',
                keys: [
                  ConfigKey(key: 'audience', value: 'https://api.example.com', createdAt: now, updatedAt: now),
                  ConfigKey(key: 'clientId', value: 'abc123', createdAt: now, updatedAt: now),
                ],
                createdAt: now,
                updatedAt: now,
              ),
              ConfigGroup(
                name: 'General Settings',
                keys: [
                  ConfigKey(key: 'app name', value: 'Test App', createdAt: now, updatedAt: now),
                  ConfigKey(key: 'version-number', value: '1.0.0', createdAt: now, updatedAt: now),
                ],
                createdAt: now,
                updatedAt: now,
              ),
            ],
            createdAt: now,
            updatedAt: now,
          ),
        ],
        selectedFlavorName: 'Development',
        selectedGroupName: 'Auth0',
      );
    });

    test('formats keys as uppercase snake case with group prefix', () {
      final command = generator.generate(
        'base64config',
        state: testState,
        command: 'run',
        flavor: 'Development',
        usePlaceholders: false,
      );

      // Should format as GROUP_NAME_KEY_NAME in uppercase snake case
      expect(command, contains('--dart-define=AUTH0_AUDIENCE=https://api.example.com'));
      expect(command, contains('--dart-define=AUTH0_CLIENT_ID=abc123'));
      expect(command, contains('--dart-define=GENERAL_SETTINGS_APP_NAME=Test App'));
      expect(command, contains('--dart-define=GENERAL_SETTINGS_VERSION_NUMBER=1.0.0'));
    });

    test('generates flutter run command', () {
      final command = generator.generate(
        'base64config',
        state: testState,
        command: 'run',
        flavor: 'Development',
        usePlaceholders: false,
      );

      expect(command, startsWith('flutter run'));
      expect(command, contains('--flavor Development'));
    });

    test('generates flutter build command', () {
      final command = generator.generate(
        'base64config',
        state: testState,
        command: 'build',
        flavor: 'Development',
        usePlaceholders: false,
      );

      expect(command, startsWith('flutter build apk'));
      expect(command, contains('--flavor Development'));
    });

    test('uses placeholders when usePlaceholders is true', () {
      final command = generator.generate(
        'base64config',
        state: testState,
        command: 'run',
        flavor: 'Development',
        usePlaceholders: true,
      );

      expect(command, contains('--dart-define=AUTH0_AUDIENCE=<value>'));
      expect(command, contains('--dart-define=AUTH0_CLIENT_ID=<value>'));
      expect(command, isNot(contains('https://api.example.com')));
      expect(command, isNot(contains('abc123')));
    });

    test('shows message when no flavor selected', () {
      final command = generator.generate(
        'base64config',
        state: testState,
        command: 'run',
        flavor: null,
        usePlaceholders: false,
      );

      expect(command, contains('# Select a flavor'));
    });

    test('handles camelCase key names', () {
      final now = DateTime.now();
      final stateWithCamelCase = ConfigState(
        flavors: [
          ConfigFlavor(
            name: 'Prod',
            groups: [
              ConfigGroup(
                name: 'API',
                keys: [
                  ConfigKey(key: 'baseUrl', value: 'https://api.com', createdAt: now, updatedAt: now),
                  ConfigKey(key: 'apiKey', value: 'secret', createdAt: now, updatedAt: now),
                ],
                createdAt: now,
                updatedAt: now,
              ),
            ],
            createdAt: now,
            updatedAt: now,
          ),
        ],
        selectedFlavorName: 'Prod',
        selectedGroupName: 'API',
      );

      final command = generator.generate(
        'base64config',
        state: stateWithCamelCase,
        command: 'run',
        flavor: 'Prod',
        usePlaceholders: false,
      );

      // camelCase should be converted to SNAKE_CASE
      expect(command, contains('--dart-define=API_BASE_URL=https://api.com'));
      expect(command, contains('--dart-define=API_API_KEY=secret'));
    });

    test('handles spaces and hyphens in names', () {
      final now = DateTime.now();
      final stateWithSpaces = ConfigState(
        flavors: [
          ConfigFlavor(
            name: 'Test',
            groups: [
              ConfigGroup(
                name: 'My Group',
                keys: [
                  ConfigKey(key: 'my-key', value: 'value1', createdAt: now, updatedAt: now),
                  ConfigKey(key: 'another key', value: 'value2', createdAt: now, updatedAt: now),
                ],
                createdAt: now,
                updatedAt: now,
              ),
            ],
            createdAt: now,
            updatedAt: now,
          ),
        ],
        selectedFlavorName: 'Test',
        selectedGroupName: 'My Group',
      );

      final command = generator.generate(
        'base64config',
        state: stateWithSpaces,
        command: 'run',
        flavor: 'Test',
        usePlaceholders: false,
      );

      // Spaces and hyphens should be converted to underscores
      expect(command, contains('--dart-define=MY_GROUP_MY_KEY=value1'));
      expect(command, contains('--dart-define=MY_GROUP_ANOTHER_KEY=value2'));
    });
  });
}
