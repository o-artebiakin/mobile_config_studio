import 'package:flutter/material.dart';

class OutputSection extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onCopy;
  final VoidCallback? onDownload;
  final String? subtitle;
  final Widget? extraControls;

  const OutputSection({
    super.key,
    required this.title,
    required this.content,
    required this.onCopy,
    this.onDownload,
    this.subtitle,
    this.extraControls,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          subtitle!,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: onCopy,
                  tooltip: 'Copy to clipboard',
                ),
                if (onDownload != null)
                  IconButton(
                    icon: const Icon(Icons.download),
                    onPressed: onDownload,
                    tooltip: 'Download file',
                  ),
              ],
            ),
            if (extraControls != null) ...[
              const SizedBox(height: 12),
              extraControls!,
            ],
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: theme.colorScheme.outlineVariant,
                ),
              ),
              constraints: const BoxConstraints(
                maxHeight: 300,
              ),
              child: SingleChildScrollView(
                child: SelectableText(
                  content,
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
