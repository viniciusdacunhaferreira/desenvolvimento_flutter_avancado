// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TodoApiModel _$TodoApiModelFromJson(Map<String, dynamic> json) =>
    _TodoApiModel(
      title: json['title'] as String,
      id: json['id'] as String,
      done: json['done'] as bool,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$TodoApiModelToJson(_TodoApiModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'id': instance.id,
      'done': instance.done,
      'description': instance.description,
    };
