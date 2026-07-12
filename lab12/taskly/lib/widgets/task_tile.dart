import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';

class TaskTile extends StatelessWidget {
  final Task task;

  // Sử dụng ValueKey để Flutter giữ đúng định danh trạng thái khi danh sách thay đổi
  const TaskTile({required Key key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Debug này để bạn chụp ảnh minh chứng trong báo cáo (Chỉ dòng này rebuild khi bấm)
    debugPrint('➔ Rebuilding TaskTile: [ID: ${task.id}] - [Title: ${task.title}]');
    
    // Dùng context.read thay vì watch vì hành động bấm nút không cần lắng nghe thay đổi ngược lại ở đây
    final taskProvider = context.read<TaskProvider>();

    return ListTile(
      leading: Checkbox(
        value: task.isCompleted,
        onChanged: (bool? value) {
          taskProvider.toggleTask(task.id);
        },
      ),
      title: Text(
        task.title,
        style: TextStyle(
          decoration: task.isCompleted ? TextDecoration.lineThrough : null,
          color: task.isCompleted ? Colors.grey : Colors.black,
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Colors.redAccent),
        onPressed: () {
          taskProvider.deleteTask(task.id);
        },
      ),
    );
  }
}