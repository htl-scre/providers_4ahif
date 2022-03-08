class Todo {
  final String id;
  final String description;
  bool done;
  static var lastId = '-';

  Todo({
    required this.description,
    this.done = false,
  }) : id = lastId {
    lastId += '-';
  }

  @override
  String toString() {
    return 'Todo{id: $id, description: $description, done: $done}';
  }
}
