class Task {
  final String id;
  String title;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    this.isCompleted = false, // Mặc định là false theo yêu cầu Lab 11.1
  });

  // Hàm toggle trạng thái true <-> false
  void toggle() {
    isCompleted = !isCompleted;
  }
}