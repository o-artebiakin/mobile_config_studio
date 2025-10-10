import 'package:flutter/material.dart';
import '../../utils/clipboard_helper.dart';
import 'output_section.dart';

class DocumentationTab extends StatelessWidget {
  final String confluenceOutput;

  const DocumentationTab({
    super.key,
    required this.confluenceOutput,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        OutputSection(
          title: 'Confluence Documentation',
          content: confluenceOutput,
          onCopy: () => ClipboardHelper.copyToClipboard(
            context,
            confluenceOutput,
            'Confluence markup copied to clipboard',
          ),
          subtitle: 'Paste directly into Confluence pages - includes tables and security notes',
        ),
      ],
    );
  }
}
