import 'package:flutter/material.dart';

class Event {
  final int? id;
  final String title;
  final String description;
  final String startTime;
  final String endTime;
  final DateTime dueDate;
  final String location;
  final String tag;

  Event({
    this.id,
    required this.title,
    required this.dueDate,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.tag,
  });

  @override
  bool operator ==(Object other) {
    if (other is! Event) {
      return false;
    }
    return identical(this, other) ||
        (this.runtimeType == other.runtimeType &&
            this.id == other.id &&
            this.title == other.title &&
            this.dueDate == other.dueDate &&
            this.description == other.description &&
            this.tag == other.tag &&
            this.startTime == other.startTime &&
            this.endTime == other.endTime &&
            this.location == other.location);
  }

  Event copyWith({
    String? title,
    String? description,
    String? startTime,
    String? endTime,
    DateTime? dueDate,
    String? location,
    int? id,
    String? tag,
  }) =>
      Event(
        title: title ?? this.title,
        description: description ?? this.description,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        dueDate: dueDate ?? this.dueDate,
        location: location ?? this.location,
        id: id ?? this.id,
        tag: tag ?? this.tag,
      );
}
