// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) {
  return Task(
      id: json['id'] as int,
      name: json['name'] as String,
      color: json['color'] as int,
      codePoint: json['code_point'] as int);
}

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'color': instance.color,
      'code_point': instance.codePoint
    };
