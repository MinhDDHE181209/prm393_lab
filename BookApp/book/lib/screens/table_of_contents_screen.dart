import 'package:flutter/material.dart';

import '../models/book.dart';
import '../models/bookmark.dart';
import '../models/chapter.dart';
import '../services/firestore_bookmark_service.dart';
import '../services/firestore_progress_service.dart';
import '../widgets/chapter_tile.dart';
import 'reader_screen.dart';

class TableOfContentsScreen extends StatefulWidget {
  const TableOfContentsScreen({super.key, required this.book});

  final Book book;

  @override
  State<TableOfContentsScreen> createState() => _TableOfContentsScreenState();
}

class _TableOfContentsScreenState extends State<TableOfContentsScreen> {
  final _bookmarkService = FirestoreBookmarkService();
  final _progressService = FirestoreProgressService();

  Future<void> _openChapter(Chapter chapter, {double? scrollOffset}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ReaderScreen(
          book: widget.book,
          chapter: chapter,
          initialScrollOffset: scrollOffset,
        ),
      ),
    );
  }

  Future<void> _continueReading(String lastChapterId) async {
    final chapter = widget.book.chapters.firstWhere(
      (c) => c.id == lastChapterId,
      orElse: () => widget.book.chapters.first,
    );
    final offset =
        await _progressService.getScrollOffset(widget.book.id, chapter.id);
    await _openChapter(chapter, scrollOffset: offset);
  }

  Future<void> _deleteBookmark(Bookmark bookmark) async {
    await _bookmarkService.removeBookmark(bookmark.id);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đã xóa bookmark')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.title),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 24),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.book.author,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.book.description,
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          StreamBuilder<String?>(
            stream: _progressService.watchLastChapterId(widget.book.id),
            builder: (context, progressSnapshot) {
              final lastChapterId = progressSnapshot.data;
              if (lastChapterId == null) return const SizedBox.shrink();

              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: FilledButton.icon(
                  onPressed: () => _continueReading(lastChapterId),
                  icon: const Icon(Icons.bookmark),
                  label: const Text('Tiếp tục đọc'),
                ),
              );
            },
          ),
          StreamBuilder<List<Bookmark>>(
            stream: _bookmarkService.watchBookmarksForBook(widget.book.id),
            builder: (context, bookmarkSnapshot) {
              final bookmarks = bookmarkSnapshot.data ?? [];
              if (bookmarks.isEmpty) return const SizedBox.shrink();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Text(
                      'Bookmark',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ...bookmarks.map((bookmark) {
                    return Dismissible(
                      key: ValueKey(bookmark.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        color: theme.colorScheme.error,
                        child: Icon(
                          Icons.delete,
                          color: theme.colorScheme.onError,
                        ),
                      ),
                      onDismissed: (_) => _deleteBookmark(bookmark),
                      child: ListTile(
                        leading: Icon(
                          Icons.bookmark,
                          color: theme.colorScheme.primary,
                        ),
                        title: Text(bookmark.chapterTitle),
                        subtitle: Text(
                          bookmark.preview,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () {
                          final chapter = widget.book.chapters.firstWhere(
                            (c) => c.id == bookmark.chapterId,
                          );
                          _openChapter(
                            chapter,
                            scrollOffset: bookmark.scrollOffset,
                          );
                        },
                      ),
                    );
                  }),
                ],
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              'Mục lục',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          StreamBuilder<String?>(
            stream: _progressService.watchLastChapterId(widget.book.id),
            builder: (context, progressSnapshot) {
              final lastChapterId = progressSnapshot.data;

              return Column(
                children: widget.book.chapters.asMap().entries.map((entry) {
                  final index = entry.key;
                  final chapter = entry.value;
                  return ChapterTile(
                    chapter: chapter,
                    index: index,
                    isLastRead: chapter.id == lastChapterId,
                    onTap: () => _openChapter(chapter),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
