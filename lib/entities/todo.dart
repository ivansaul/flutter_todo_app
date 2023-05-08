class Todo {
  final String id;
  final String description;
  final bool completed;
  // final String title;
  // final String subtitle;

  Todo({
    required this.id,
    required this.description,
    required this.completed,
    // required this.title,
    // required this.subtitle,
  });

  Todo copyWith({
    String? id,
    String? description,
    bool? completed,
    // String? title,
    // String? subtitle,
  }) =>
      Todo(
        id: id ?? this.id,
        description: description ?? this.description,
        completed: completed ?? this.completed,
        // title: title ?? this.title,
        // subtitle: subtitle ?? this.subtitle,
      );

  // factory Todo.fromJson(Map<String, dynamic> json) => Todo(
  //     id: json["id"],
  //     title: json["title"],
  //     subtitle: json["subtitle"],
  //     isCompleted: json["isCompleted"],
  // );

  // Map<String, dynamic> toJson() => {
  //     "id": id,
  //     "title": title,
  //     "subtitle": subtitle,
  //     "isCompleted": isCompleted,
  // };
}
