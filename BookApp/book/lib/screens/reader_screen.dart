import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../models/book.dart';
import '../models/bookmark.dart';
import '../models/chapter.dart';
import '../services/firestore_bookmark_service.dart';
import '../services/firestore_progress_service.dart';

class ReaderScreen extends StatefulWidget {
  const ReaderScreen({
    super.key,
    required this.book,
    required this.chapter,
    this.initialScrollOffset,
  });

  final Book book;
  final Chapter chapter;
  final double? initialScrollOffset;

  @override
  State<ReaderScreen> createState() => _ReaderScreenState();
}

class _ReaderScreenState extends State<ReaderScreen> {
  late final ScrollController _scrollController;
  final _bookmarkService = FirestoreBookmarkService();
  final _progressService = FirestoreProgressService();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(
      initialScrollOffset: widget.initialScrollOffset ?? 0,
    );
    _scrollController.addListener(_onScroll);
    _restoreProgress();
  }

  Future<void> _restoreProgress() async {
    _progressService.saveLastChapter(widget.book.id, widget.chapter.id);

    if (widget.initialScrollOffset != null) return;

    final offset = await _progressService.getScrollOffset(
      widget.book.id,
      widget.chapter.id,
    );
    if (!mounted || offset <= 0) return;

    _jumpToOffset(offset);
  }

  void _jumpToOffset(double offset) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scrollController.hasClients) return;

      final maxScroll = _scrollController.position.maxScrollExtent;
      final target = offset.clamp(0.0, maxScroll);
      if ((_scrollController.offset - target).abs() > 1) {
        _scrollController.jumpTo(target);
      }
    });
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    _progressService.saveScrollOffset(
      widget.book.id,
      widget.chapter.id,
      _scrollController.offset,
    );
  }

  Future<void> _addBookmark() async {
    if (!_scrollController.hasClients) return;

    final offset = _scrollController.offset;
    final preview = _getPreviewAtOffset(offset);

    final bookmark = Bookmark(
      id: '${widget.book.id}_${widget.chapter.id}_${DateTime.now().millisecondsSinceEpoch}',
      bookId: widget.book.id,
      chapterId: widget.chapter.id,
      chapterTitle: widget.chapter.title,
      scrollOffset: offset,
      preview: preview,
      createdAt: DateTime.now(),
    );

    await _bookmarkService.addBookmark(bookmark);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đã thêm bookmark')),
      );
    }
  }

  String _getPreviewAtOffset(double offset) {
    const lineHeight = 28.0;
    final lines = widget.chapter.content.split('\n');
    final lineIndex = (offset / lineHeight).floor().clamp(0, lines.length - 1);
    final preview = lines[lineIndex].trim();
    return preview.isEmpty ? widget.chapter.title : preview;
  }

  Chapter? _getAdjacentChapter(int delta) {
    final chapters = widget.book.chapters;
    final index = chapters.indexWhere((c) => c.id == widget.chapter.id);
    if (index == -1) return null;

    final nextIndex = index + delta;
    if (nextIndex < 0 || nextIndex >= chapters.length) return null;
    return chapters[nextIndex];
  }

  void _navigateToChapter(Chapter chapter) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ReaderScreen(book: widget.book, chapter: chapter),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final prevChapter = _getAdjacentChapter(-1);
    final nextChapter = _getAdjacentChapter(1);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.chapter.title,
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          IconButton(
            onPressed: _addBookmark,
            icon: const Icon(Icons.bookmark_add_outlined),
            tooltip: 'Thêm bookmark',
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: const EdgeInsets.all(24),
        child: Text(
          widget.chapter.content,
          style: theme.textTheme.bodyLarge?.copyWith(
            height: 1.8,
            fontSize: 18,
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: prevChapter != null
                    ? () => _navigateToChapter(prevChapter)
                    : null,
                icon: const Icon(Icons.arrow_back),
                label: const Text('Trước'),
              ),
              TextButton.icon(
                onPressed: nextChapter != null
                    ? () => _navigateToChapter(nextChapter)
                    : null,
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Sau'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
