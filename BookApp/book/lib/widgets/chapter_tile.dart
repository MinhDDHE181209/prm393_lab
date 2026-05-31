import 'package:flutter/material.dart';

import '../models/chapter.dart';

class ChapterTile extends StatelessWidget {
  const ChapterTile({
    super.key,
    required this.chapter,
    required this.index,
    required this.onTap,
    this.isLastRead = false,
  });

  final Chapter chapter;
  final int index;
  final VoidCallback onTap;
  final bool isLastRead;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: isLastRead
            ? theme.colorScheme.primary
            : theme.colorScheme.primaryContainer,
        child: Text(
          '${index + 1}',
          style: TextStyle(
            color: isLastRead
                ? theme.colorScheme.onPrimary
                : theme.colorScheme.onPrimaryContainer,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(chapter.title),
      subtitle: isLastRead ? const Text('Đang đọc dở') : null,
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
