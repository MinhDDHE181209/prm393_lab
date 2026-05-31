class Chapter {
  const Chapter({
    required this.id,
    required this.title,
    required this.content,
  });

  final String id;
  final String title;
  final String content;

  factory Chapter.fromMap(Map<String, dynamic> map) => Chapter(
        id: map['id'] as String,
        title: map['title'] as String,
        content: map['content'] as String,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'content': content,
      };
}
