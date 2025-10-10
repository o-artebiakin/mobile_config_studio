import 'package:flutter_test/flutter_test.dart';

import 'package:mobile_config_studio/models/config_flavor.dart';
import 'package:mobile_config_studio/models/config_group.dart';
import 'package:mobile_config_studio/models/config_key.dart';
import 'package:mobile_config_studio/providers/config_provider.dart';
import 'package:mobile_config_studio/services/generators/android_studio_config_generator.dart';

void main() {
  group('AndroidStudioConfigGenerator', () {
    late AndroidStudioConfigGenerator generator;
    late ConfigFlavor testFlavor;

    setUp(() {
      generator = AndroidStudioConfigGenerator();
      final now = DateTime.now();
      
      testFlavor = ConfigFlavor(
        name: 'hdDev',
        groups: [
          ConfigGroup(
            name: 'Auth0',
            keys: [
              ConfigKey(key: 'audience', value: 'https://yourhddev-api.web.app', createdAt: now, updatedAt: now),
              ConfigKey(key: 'domain', value: 'login-dev.hastingsdeering.com.au', createdAt: now, updatedAt: now),
              ConfigKey(key: 'clientIdIOS', value: '0Oi7EA36vyHP37Nml9u6GDSNOEfihlmM', createdAt: now, updatedAt: now),
            ],
            createdAt: now,
            updatedAt: now,
          ),
          ConfigGroup(
            name: 'Cloud',
            keys: [
              ConfigKey(key: 'apiUrl', value: 'https://australia-southeast1-uplatformdev.cloudfunctions.net', createdAt: now, updatedAt: now),
            ],
            createdAt: now,
            updatedAt: now,
          ),
        ],
        createdAt: now,
        updatedAt: now,
      );
    });

    test('generates valid XML structure for .run.xml file', () {
      final xml = generator.generateRunXml(testFlavor);

      // Check XML structure
      expect(xml, contains('<component name="ProjectRunConfigurationManager">'));
      expect(xml, contains('<configuration default="false" name="Flutter (hdDev)"'));
      expect(xml, contains('type="FlutterRunConfigurationType"'));
      expect(xml, contains('factoryName="Flutter">'));
      expect(xml, contains('</configuration>'));
      expect(xml, contains('</component>'));
    });

    test('includes additionalArgs with all dart-defines', () {
      final xml = generator.generateRunXml(testFlavor);

      expect(xml, contains('<option name="additionalArgs"'));
      expect(xml, contains('--dart-define=AUTH0_AUDIENCE=https://yourhddev-api.web.app'));
      expect(xml, contains('--dart-define=AUTH0_DOMAIN=login-dev.hastingsdeering.com.au'));
      expect(xml, contains('--dart-define=AUTH0_CLIENT_ID_IOS=0Oi7EA36vyHP37Nml9u6GDSNOEfihlmM'));
      expect(xml, contains('--dart-define=CLOUD_API_URL=https://australia-southeast1-uplatformdev.cloudfunctions.net'));
    });

    test('includes buildFlavor option with exact flavor name', () {
      final xml = generator.generateRunXml(testFlavor);

      expect(xml, contains('<option name="buildFlavor" value="hdDev" />'));
    });

    test('includes filePath option', () {
      final xml = generator.generateRunXml(testFlavor);

      expect(xml, contains('<option name="filePath" value="\$PROJECT_DIR\$/lib/main.dart" />'));
    });

    test('includes method v="2" tag', () {
      final xml = generator.generateRunXml(testFlavor);

      expect(xml, contains('<method v="2" />'));
    });

    test('generate() creates instructions with XML for all flavors', () {
      final now = DateTime.now();
      final state = ConfigState(
        flavors: [
          testFlavor,
          ConfigFlavor(
            name: 'Production',
            groups: [
              ConfigGroup(
                name: 'API',
                keys: [
                  ConfigKey(key: 'url', value: 'https://prod.api.com', createdAt: now, updatedAt: now),
                ],
                createdAt: now,
                updatedAt: now,
              ),
            ],
            createdAt: now,
            updatedAt: now,
          ),
        ],
        selectedFlavorName: 'hdDev',
        selectedGroupName: 'Auth0',
      );

      final output = generator.generate(state);

      expect(output, contains('# Android Studio Run Configurations (.run.xml files)'));
      expect(output, contains('## Flutter (hdDev).run.xml'));
      expect(output, contains('## Flutter (Production).run.xml'));
      expect(output, contains('```xml'));
      expect(output, contains('<component name="ProjectRunConfigurationManager">'));
    });

    test('generateDownloadableInstructions() creates downloadable format', () {
      final state = ConfigState(
        flavors: [testFlavor],
        selectedFlavorName: 'hdDev',
        selectedGroupName: 'Auth0',
      );

      final output = generator.generateDownloadableInstructions(state);

      expect(output, contains('Android Studio Run Configurations - Setup Instructions'));
      expect(output, contains('STEP 1: Create the .run folder'));
      expect(output, contains('FILE: .run/Flutter (hdDev).run.xml'));
      expect(output, contains('<component name="ProjectRunConfigurationManager">'));
    });
  });
}
