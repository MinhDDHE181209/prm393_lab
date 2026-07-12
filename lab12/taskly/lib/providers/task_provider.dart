import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  // Sử dụng một danh sách mới hoàn toàn để Selector nhận diện được sự thay đổi reference
  List<Task> _tasks = [
    Task(id: '1', title: 'Học bài Module 12 Performance'),
    Task(id: '2', title: 'Làm bài tập Lab 12 tối ưu Rebuild'),
    Task(id: '3', title: 'Chạy thử Profile mode kiểm tra FPS'),
  ];

  List<Task> get tasks => List.unmodifiable(_tasks);

  // Thêm Task mới
  void addTask(String title) {
    final newTask = Task(id: DateTime.now().toString(), title: title);
    _tasks = [..._tasks, newTask];
    notifyListeners();
  }

  // Tối ưu hóa: Chỉ thay đổi đúng phần tử được toggle và tạo list mới
  void toggleTask(String id) {
    _tasks = _tasks.map((task) {
      if (task.id == id) {
        return task.copyWith(isCompleted: !task.isCompleted);
      }
      return task;
    }).toList();
    notifyListeners();
  }

  // Xóa Task
  void deleteTask(String id) {
    _tasks = _tasks.where((task) => task.id != id).toList();
    notifyListeners();
  }
}