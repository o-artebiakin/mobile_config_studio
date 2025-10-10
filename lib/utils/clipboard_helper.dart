import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Conditional import for web-only functionality
import 'clipboard_helper_stub.dart'
    if (dart.library.html) 'clipboard_helper_web.dart' as platform;

class ClipboardHelper {
  static Future<void> copyToClipboard(
    BuildContext context,
    String text,
    String message,
  ) async {
    await Clipboard.setData(ClipboardData(text: text));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).colorScheme.primary,
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  static Future<void> downloadJson(BuildContext context, String jsonString) async {
    if (kIsWeb) {
      // For web, copy download instruction to clipboard
      await copyToClipboard(
        context,
        jsonString,
        'JSON copied! Save it as config.json',
      );
    } else {
      // For mobile/desktop, show not implemented message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Download feature available on web platform'),
            backgroundColor: Theme.of(context).colorScheme.secondary,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  static Future<void> downloadRunConfigurations(
    BuildContext context,
    Map<String, String> runFiles,
  ) async {
    if (kIsWeb) {
      try {
        // Create a ZIP archive
        final archive = Archive();

        // Add each .run.xml file to the archive
        for (final entry in runFiles.entries) {
          final fileName = entry.key;
          final fileContent = entry.value;
          final bytes = utf8.encode(fileContent);
          
          archive.addFile(
            ArchiveFile('.run/$fileName', bytes.length, bytes),
          );
        }

        // Encode the archive to ZIP format
        final zipEncoder = ZipEncoder();
        final zipBytes = zipEncoder.encode(archive);

        // Download the ZIP file using platform-specific implementation
        platform.downloadZipFile(zipBytes, 'android_studio_run_configs.zip');

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Run configurations downloaded as ZIP!'),
              backgroundColor: Theme.of(context).colorScheme.primary,
              duration: const Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error creating ZIP: $e'),
              backgroundColor: Theme.of(context).colorScheme.error,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    } else {
      // For mobile/desktop, show not implemented message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Download feature available on web platform'),
            backgroundColor: Theme.of(context).colorScheme.secondary,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }
}
