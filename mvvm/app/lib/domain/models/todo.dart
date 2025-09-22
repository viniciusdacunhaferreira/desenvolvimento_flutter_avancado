class Todo {
  Todo({
    required this.id,
    required this.title,
    required this.done,
    this.description,
  });

  final String id;
  final String title;
  final bool done;
  final String? description;

  Todo copyWith({
    String? id,
    String? title,
    bool? done,
    String? description,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      done: done ?? this.done,
      description: description ?? this.description,
    );
  }
}
