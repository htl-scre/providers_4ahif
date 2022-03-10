class Todo {
  String? id;
  final String description;
  bool done;

  Todo({
    this.id,
    required this.description,
    this.done = false,
  });

  Todo.fromJson(Map<String, dynamic> json, String id)
      : this(
          id: id,
          description: json['description'],
          done: json['done'],
        );

  @override
  String toString() {
    return 'Todo{id: $id, description: $description, done: $done}';
  }

  Map<String, dynamic> toJson() {
    return {
      'description': description,
      'done': done,
    };
  }
}
