import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
}
