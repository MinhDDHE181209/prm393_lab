import 'package:flutter/material.dart';
import '../models/task.dart';
import 'task_detail_screen.dart';

class TaskListScreen extends StatefulWidget {
  final List<Task>? initialTasks; // Dùng cho bài test navigation/integration để seed dữ liệu

  const TaskListScreen({super.key, this.initialTasks});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final List<Task> _tasks = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialTasks != null) {
      _tasks.addAll(widget.initialTasks!);
    }
  }

  void _addTask() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _tasks.add(Task(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: _controller.text,
        ));
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Taskly')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(labelText: 'Enter task...'),
                  ),
                ),
                FloatingActionButton(
                  onPressed: _addTask,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
          ),
          Expanded(
            child: _tasks.isEmpty
                ? const Center(child: Text('No tasks yet. Add one!')) // Khớp với Widget Test
                : ListView.builder(
                    itemCount: _tasks.length,
                    itemBuilder: (context, index) {
                      final task = _tasks[index];
                      return ListTile(
                        title: Text(task.title),
                        onTap: () async {
                          // Chuyển sang màn hình Detail và chờ kết quả cập nhật mang về
                          final updatedTitle = await Navigator.push<String>(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TaskDetailScreen(task: task),
                            ),
                          );
                          if (updatedTitle != null && mounted) {
                            setState(() {
                              task.title = updatedTitle;
                            });
                          }
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}