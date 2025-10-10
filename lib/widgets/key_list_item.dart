import 'package:flutter/material.dart';
import '../models/config_key.dart';

class KeyListItem extends StatefulWidget {
  final ConfigKey configKey;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final bool isNew;

  const KeyListItem({
    super.key,
    required this.configKey,
    required this.onEdit,
    required this.onDelete,
    this.isNew = false,
  });

  @override
  State<KeyListItem> createState() => _KeyListItemState();
}

class _KeyListItemState extends State<KeyListItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    if (widget.isNew) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Create color animation based on theme
    final highlightColor = Theme.of(context).colorScheme.primary.withValues(alpha: 0.15);
    
    _colorAnimation = ColorTween(
      begin: highlightColor,
      end: Colors.transparent,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: widget.isNew ? _colorAnimation.value : null,
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).dividerColor.withValues(alpha: 0.3),
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  widget.configKey.key,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  widget.configKey.value,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              SizedBox(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit_outlined, size: 20),
                      tooltip: 'Edit',
                      onPressed: widget.onEdit,
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, size: 20),
                      tooltip: 'Delete',
                      onPressed: widget.onDelete,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
