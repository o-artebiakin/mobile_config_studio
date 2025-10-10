import 'dart:convert';

import 'package:flutter/foundation.dart';

void main() {
  // Create demo configuration with multiple flavors
  final demoConfig = {
    'flavors': [
      {
        'name': 'Development',
        'groups': [
          {
            'name': 'General',
            'keys': [
              {'key': 'app_name', 'value': 'Config Studio Dev'},
              {'key': 'version', 'value': '1.0.0-dev'},
              {'key': 'environment', 'value': 'development'},
            ]
          },
          {
            'name': 'Network',
            'keys': [
              {'key': 'api_url', 'value': 'https://dev-api.example.com'},
              {'key': 'timeout', 'value': '30'},
              {'key': 'debug_mode', 'value': 'true'},
            ]
          },
          {
            'name': 'Features',
            'keys': [
              {'key': 'enable_logging', 'value': 'true'},
              {'key': 'enable_analytics', 'value': 'false'},
            ]
          }
        ]
      },
      {
        'name': 'Staging',
        'groups': [
          {
            'name': 'General',
            'keys': [
              {'key': 'app_name', 'value': 'Config Studio Staging'},
              {'key': 'version', 'value': '1.0.0-rc1'},
              {'key': 'environment', 'value': 'staging'},
            ]
          },
          {
            'name': 'Network',
            'keys': [
              {'key': 'api_url', 'value': 'https://staging-api.example.com'},
              {'key': 'timeout', 'value': '45'},
              {'key': 'debug_mode', 'value': 'false'},
            ]
          }
        ]
      },
      {
        'name': 'Production',
        'groups': [
          {
            'name': 'General',
            'keys': [
              {'key': 'app_name', 'value': 'Config Studio'},
              {'key': 'version', 'value': '1.0.0'},
              {'key': 'environment', 'value': 'production'},
            ]
          },
          {
            'name': 'Network',
            'keys': [
              {'key': 'api_url', 'value': 'https://api.example.com'},
              {'key': 'timeout', 'value': '60'},
              {'key': 'debug_mode', 'value': 'false'},
            ]
          },
          {
            'name': 'Features',
            'keys': [
              {'key': 'enable_logging', 'value': 'false'},
              {'key': 'enable_analytics', 'value': 'true'},
              {'key': 'enable_crash_reporting', 'value': 'true'},
            ]
          }
        ]
      }
    ]
  };

  // Convert to JSON string
  final jsonString = jsonEncode(demoConfig);

  // Encode to base64
  final base64String = base64Encode(utf8.encode(jsonString));

  debugPrint('=== DEMO CONFIGURATION ===\n');
  debugPrint('JSON:');
  debugPrint(const JsonEncoder.withIndent('  ').convert(demoConfig));
  debugPrint('\n=== BASE64 ENCODED ===\n');
  debugPrint(base64String);
  debugPrint('\n=== TEST URLS ===\n');
  debugPrint('Local:');
  debugPrint('http://localhost:8080/?config=$base64String');
  debugPrint('\nGitHub Pages:');
  debugPrint('https://o-artebiakin.github.io/mobile_config_studio/?config=$base64String');

  // Create a simpler demo with just one flavor for quick testing
  final simpleDemoConfig = {
    'flavors': [
      {
        'name': 'Demo',
        'groups': [
          {
            'name': 'App Settings',
            'keys': [
              {'key': 'app_name', 'value': 'My Flutter App'},
              {'key': 'version', 'value': '1.0.0'},
            ]
          },
          {
            'name': 'API Config',
            'keys': [
              {'key': 'base_url', 'value': 'https://api.example.com'},
              {'key': 'api_key', 'value': 'demo_key_12345'},
            ]
          }
        ]
      }
    ]
  };

  final simpleBase64 = base64Encode(utf8.encode(jsonEncode(simpleDemoConfig)));

  debugPrint('\n=== SIMPLE DEMO (1 Flavor) ===\n');
  debugPrint('Base64: $simpleBase64');
  debugPrint('\nLocal URL:');
  debugPrint('http://localhost:8080/?config=$simpleBase64');
}
