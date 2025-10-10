import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_config_studio/models/config_flavor.dart';
import 'package:mobile_config_studio/models/config_group.dart';
import 'package:mobile_config_studio/models/config_key.dart';
import 'package:mobile_config_studio/providers/config_provider.dart';
import 'package:mobile_config_studio/services/generators/env_dart_generator.dart';

void main() {
  group('EnvDartGenerator', () {
    late EnvDartGenerator generator;
    late DateTime now;

    setUp(() {
      generator = EnvDartGenerator();
      now = DateTime.now();
    });

    test('generate() creates env.dart file with String.fromEnvironment', () {
      final state = ConfigState(
        flavors: [
          ConfigFlavor(
            name: 'Development',
            groups: [
              ConfigGroup(
                name: 'Network',
                keys: [
                  ConfigKey(
                    key: 'api_url',
                    value: 'https://dev.api.com',
                    createdAt: now,
                    updatedAt: now,
                  ),
                ],
                createdAt: now,
                updatedAt: now,
              ),
              ConfigGroup(
                name: 'Auth0',
                keys: [
                  ConfigKey(
                    key: 'audience',
                    value: 'https://dev-api.web.app',
                    createdAt: now,
                    updatedAt: now,
                  ),
                  ConfigKey(
                    key: 'client_id',
                    value: 'abc123',
                    createdAt: now,
                    updatedAt: now,
                  ),
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
        selectedGroupName: 'Network',
      );

      final output = generator.generate(state);

      expect(output, contains('final class Env {'));
      expect(output, contains('const Env._();'));
      expect(output, contains('// NETWORK'));
      expect(output, contains('// AUTH0'));
      expect(output, contains('static const networkApiUrl = String.fromEnvironment(\'NETWORK_API_URL\');'));
      expect(output, contains('static const auth0Audience = String.fromEnvironment(\'AUTH0_AUDIENCE\');'));
      expect(output, contains('static const auth0ClientId = String.fromEnvironment(\'AUTH0_CLIENT_ID\');'));
    });

    test('generate() handles camelCase field names correctly', () {
      final state = ConfigState(
        flavors: [
          ConfigFlavor(
            name: 'Dev',
            groups: [
              ConfigGroup(
                name: 'DataDog',
                keys: [
                  ConfigKey(
                    key: 'app_id',
                    value: 'test',
                    createdAt: now,
                    updatedAt: now,
                  ),
                ],
                createdAt: now,
                updatedAt: now,
              ),
            ],
            createdAt: now,
            updatedAt: now,
          ),
        ],
        selectedFlavorName: 'Dev',
        selectedGroupName: 'DataDog',
      );

      final output = generator.generate(state);

      expect(output, contains('static const dataDogAppId'));
      expect(output, contains('String.fromEnvironment(\'DATA_DOG_APP_ID\')'));
    });

    test('generate() handles spaces in names', () {
      final state = ConfigState(
        flavors: [
          ConfigFlavor(
            name: 'Dev',
            groups: [
              ConfigGroup(
                name: 'General Settings',
                keys: [
                  ConfigKey(
                    key: 'app name',
                    value: 'My App',
                    createdAt: now,
                    updatedAt: now,
                  ),
                ],
                createdAt: now,
                updatedAt: now,
              ),
            ],
            createdAt: now,
            updatedAt: now,
          ),
        ],
        selectedFlavorName: 'Dev',
        selectedGroupName: 'General Settings',
      );

      final output = generator.generate(state);

      expect(output, contains('// GENERAL_SETTINGS'));
      expect(output, contains('static const generalSettingsAppName'));
      expect(output, contains('String.fromEnvironment(\'GENERAL_SETTINGS_APP_NAME\')'));
    });

    test('generate() handles multiple groups', () {
      final state = ConfigState(
        flavors: [
          ConfigFlavor(
            name: 'Dev',
            groups: [
              ConfigGroup(
                name: 'Network',
                keys: [
                  ConfigKey(
                    key: 'api_url',
                    value: 'https://api.com',
                    createdAt: now,
                    updatedAt: now,
                  ),
                ],
                createdAt: now,
                updatedAt: now,
              ),
              ConfigGroup(
                name: 'Auth',
                keys: [
                  ConfigKey(
                    key: 'token',
                    value: 'secret',
                    createdAt: now,
                    updatedAt: now,
                  ),
                ],
                createdAt: now,
                updatedAt: now,
              ),
            ],
            createdAt: now,
            updatedAt: now,
          ),
        ],
        selectedFlavorName: 'Dev',
        selectedGroupName: 'Network',
      );

      final output = generator.generate(state);

      expect(output, contains('// NETWORK'));
      expect(output, contains('static const networkApiUrl'));
      expect(output, contains('// AUTH'));
      expect(output, contains('static const authToken'));
    });

    test('generate() only uses first flavor to avoid duplicates', () {
      final state = ConfigState(
        flavors: [
          ConfigFlavor(
            name: 'Dev',
            groups: [
              ConfigGroup(
                name: 'API',
                keys: [
                  ConfigKey(
                    key: 'url',
                    value: 'dev.com',
                    createdAt: now,
                    updatedAt: now,
                  ),
                ],
                createdAt: now,
                updatedAt: now,
              ),
            ],
            createdAt: now,
            updatedAt: now,
          ),
          ConfigFlavor(
            name: 'Prod',
            groups: [
              ConfigGroup(
                name: 'API',
                keys: [
                  ConfigKey(
                    key: 'url',
                    value: 'prod.com',
                    createdAt: now,
                    updatedAt: now,
                  ),
                ],
                createdAt: now,
                updatedAt: now,
              ),
            ],
            createdAt: now,
            updatedAt: now,
          ),
        ],
        selectedFlavorName: 'Dev',
        selectedGroupName: 'API',
      );

      final output = generator.generate(state);

      // Should only contain one definition of apiUrl
      expect('static const apiUrl'.allMatches(output).length, equals(1));
    });

    test('generate() includes file header', () {
      final state = ConfigState(
        flavors: [
          ConfigFlavor(
            name: 'Dev',
            groups: [
              ConfigGroup(
                name: 'Test',
                keys: [
                  ConfigKey(
                    key: 'key',
                    value: 'value',
                    createdAt: now,
                    updatedAt: now,
                  ),
                ],
                createdAt: now,
                updatedAt: now,
              ),
            ],
            createdAt: now,
            updatedAt: now,
          ),
        ],
        selectedFlavorName: 'Dev',
        selectedGroupName: 'Test',
      );

      final output = generator.generate(state);

      expect(output, contains('// coverage:ignore-file'));
      expect(output, contains('// GENERATED CODE - DO NOT MODIFY BY HAND'));
      expect(output, contains('// Generated by Mobile Config Studio'));
    });
  });
}
