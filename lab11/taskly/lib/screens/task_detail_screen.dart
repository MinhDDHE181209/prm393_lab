import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskDetailScreen extends StatefulWidget {
  final Task task;

  const TaskDetailScreen({super.key, required this.task});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.task.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Detail'), // Khớp với Navigation Test
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              key: const Key('detailTitleField'), // Khớp với Key trong bài test
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Task Title'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              key: const Key('saveDetailButton'), // Khớp với Key trong Integration Test
              onPressed: () {
                Navigator.pop(context, _controller.text); // Trả lại title mới về màn hình trước
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}