import 'package:isar/isar.dart';

part 'todo.g.dart';

@Collection()
class Todo {
  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.date,
  });

  final Id id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime date;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Todo &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.isCompleted == isCompleted &&
        other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        isCompleted.hashCode ^
        date.hashCode;
  }

  Todo copyWith({
    Id? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? date,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      date: date ?? this.date,
    );
  }

  @override
  String toString() {
    return 'Todo(id: $id, title: $title, description: $description, isCompleted: $isCompleted, date: $date)';
  }

  int fastHash(String string) {
    var hash = 0xcbf29ce484222325;

    var i = 0;
    while (i < string.length) {
      final codeUnit = string.codeUnitAt(i++);
      hash ^= codeUnit >> 8;
      hash *= 0x100000001b3;
      hash ^= codeUnit & 0xFF;
      hash *= 0x100000001b3;
    }

    return hash;
  }
}
