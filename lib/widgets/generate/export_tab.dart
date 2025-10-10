import 'package:flutter/material.dart';
import '../../utils/clipboard_helper.dart';
import 'output_section.dart';

class ExportTab extends StatelessWidget {
  final String jsonOutput;
  final String base64Output;

  const ExportTab({
    super.key,
    required this.jsonOutput,
    required this.base64Output,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        OutputSection(
          title: 'JSON Configuration',
          content: jsonOutput,
          onCopy: () => ClipboardHelper.copyToClipboard(
            context,
            jsonOutput,
            'JSON copied to clipboard',
          ),
          onDownload: () => ClipboardHelper.downloadJson(context, jsonOutput),
          subtitle: 'Pretty-printed JSON for manual integration or importing',
        ),
        const SizedBox(height: 24),
        OutputSection(
          title: 'Base64 Encoded',
          content: base64Output,
          onCopy: () => ClipboardHelper.copyToClipboard(
            context,
            base64Output,
            'Base64 copied to clipboard',
          ),
          subtitle: 'Use in URL parameters or runtime configuration',
        ),
      ],
    );
  }
}
