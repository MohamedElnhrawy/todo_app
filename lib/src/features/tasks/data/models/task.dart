import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/core/utils/typedefs.dart';
import 'package:todo_app/src/features/tasks/domain/entities/task.dart';
part 'task.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {


  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String? description;

  @HiveField(3)
  final DateTime createdAt;

  @HiveField(4)
  final DateTime updatedAt;

  @HiveField(5)
  final bool isCompleted;


  TaskModel({
    required this.id,
    required this.title,
    this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.isCompleted,
  });


  TaskModel.empty() : this(
    id: '',
    title: '',
    description: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    isCompleted: false,
  );

  TaskModel.fromMap(DataMap map)
      : this(
    id: map['id'] as String,
    title: map['title'] as String,
    description: map['description'] as String?,
    createdAt: (map['createdAt'] as Timestamp).toDate(),
    updatedAt: (map['updatedAt'] as Timestamp).toDate(),
    isCompleted: map['isCompleted'] as bool
  );

  // Convert a Map into a TaskModel
  factory TaskModel.fromFireStore(String id, Map<String, dynamic> map) {
    return TaskModel(
      id: id,
      title: map['title'] as String,
      description: map['description'] as String,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
      isCompleted : map['isCompleted'] as bool,
    );
  }

  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isCompleted,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  DataMap toMap() => {
    'id': id,
    'title': title,
    'description': description,
    'createdAt': FieldValue.serverTimestamp(),
    'updatedAt': FieldValue.serverTimestamp(),
    'isCompleted':isCompleted
  };
  
  LocalTask toLocalTask() => LocalTask(
    id: id,
    title: title,
    description: description,
    createdAt: createdAt,
    updatedAt: updatedAt,
    isCompleted: isCompleted,
  );

  @override
  List<Object?> get props => [id];

}
