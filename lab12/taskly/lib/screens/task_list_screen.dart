import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../models/task.dart';
import '../widgets/task_tile.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Exercise 12.2: Tối ưu hóa tải trước hình ảnh vào bộ nhớ đệm (Pre-cache)
    // Đảm bảo bạn đã có file ảnh này hoặc thay bằng ảnh có sẵn trong thư mục assets của bạn
    try {
      precacheImage(const AssetImage('assets/images/task_success_icon.png'), context);
      debugPrint('➔ Pre-cached thành công ảnh thành công!');
    } catch (e) {
      debugPrint('Bỏ qua pre-cache nếu chưa cấu hình asset ảnh: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Thấy dòng này in ra tức là toàn bộ màn hình bị rebuild (Cần hạn chế)
    debugPrint('➔ Rebuilding TOÀN BỘ MÀN HÌNH TaskListScreen (Hệ thống tĩnh)');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Taskly - Đã Tối Ưu Hóa'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Widget tĩnh mẫu hiển thị Icon đã được tối ưu cache
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.bolt, color: Colors.amber),
                SizedBox(width: 8),
                Text('Ứng dụng hoạt động mượt mà (60 FPS)', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(
            // Dùng Selector thay vì Consumer/Watch để chỉ rebuild khi danh sách Task thay đổi thực sự
            child: Selector<TaskProvider, List<Task>>(
              selector: (_, provider) => provider.tasks,
              builder: (context, tasks, child) {
                debugPrint('➔ Selector phát hiện danh sách thay đổi: Chỉ Rebuild List/Tile con');
                if (tasks.isEmpty) {
                  return const Center(
                    child: Text('Danh sách trống. Hãy thêm công việc mới!'),
                  );
                }
                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return TaskTile(
                      key: ValueKey(task.id), // Bắt buộc cho Exercise 12.1
                      task: task,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Thêm công việc mới'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Nhập tiêu đề...'),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                context.read<TaskProvider>().addTask(controller.text.trim());
                Navigator.pop(context);
              }
            },
            child: const Text('Thêm'),
          ),
        ],
      ),
    );
  }
}