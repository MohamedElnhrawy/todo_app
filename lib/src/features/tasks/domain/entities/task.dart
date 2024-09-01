import 'package:equatable/equatable.dart';
import 'package:todo_app/src/features/tasks/data/models/task.dart';

class LocalTask extends Equatable {
  const LocalTask(
      {required this.id,
      required this.title,
      this.description,
      required this.createdAt,
      required this.updatedAt,
      required this.isCompleted});

  final String id;
  final String title;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isCompleted;

  LocalTask.empty()
      : this(
          id: '',
          title: '',
          description: '',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          isCompleted: false,
        );

  LocalTask copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isCompleted,
  }) {
    return LocalTask(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isCompleted: isCompleted ?? this.isCompleted);
  }

  TaskModel toTaskModel() => TaskModel(
      id: id,
      title: title,
      createdAt: createdAt,
      updatedAt: updatedAt,
      isCompleted: isCompleted,
      description: description);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      // Convert DateTime to ISO 8601 string
      'updatedAt': updatedAt.toIso8601String(),
      // Convert DateTime to ISO 8601 string
      'isCompleted': isCompleted,
    };
  }

  LocalTask.fromMap(Map<String, dynamic> map)
      : this(
          id: map['id'] as String,
          title: map['title'] as String,
          description: map['description'] as String?,
          createdAt: DateTime.parse(map['createdAt'] as String),
          // Convert ISO 8601 string back to DateTime
          updatedAt: DateTime.parse(map['updatedAt'] as String),
          // Convert ISO 8601 string back to DateTime
          isCompleted: map['isCompleted'] as bool,
        );

  @override
  List<Object?> get props => [id];
}
