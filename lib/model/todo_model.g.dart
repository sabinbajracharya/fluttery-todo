// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Todo _$TodoFromJson(Map<String, dynamic> json) {
  return Todo(
      id: json['id'] as int,
      parent: json['parent'] as int,
      name: json['name'] as String,
      isCompleted: json['completed'] as int);
}

Map<String, dynamic> _$TodoToJson(Todo instance) => <String, dynamic>{
      'id': instance.id,
      'parent': instance.parent,
      'name': instance.name,
      'completed': instance.isCompleted
    };
