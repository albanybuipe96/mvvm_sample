import 'package:flutter/cupertino.dart';

@immutable
class Task {
  int? id;
  final String title;
  final String description;
  final bool done;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.done,
  });

  // set setId(int? value) => id = value;

  @override
  bool operator ==(Object other) {
    return other is Task && other.hashCode == hashCode;
  }

  @override
  int get hashCode => Object.hash(id, title, description, done);
}
