import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task_model.g.dart';

@JsonSerializable()
class Task {
  int id;
  String name;
  int color;
  @JsonKey(name: 'code_point')
  int codePoint;

  Task({@required this.id, @required this.name, @required this.color, @required this.codePoint});

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$TaskFromJson()` constructor.
  /// The constructor is named after the source class, in this case User.
  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$TaskFromJson`.
  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
