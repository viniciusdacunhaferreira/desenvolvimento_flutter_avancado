import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_api_model.freezed.dart';
part 'todo_api_model.g.dart';

@freezed
abstract class TodoApiModel with _$TodoApiModel {
  const factory TodoApiModel({
    required String title,
    required String id,
    required bool done,
    String? description,
  }) = _TodoApiModel;

  factory TodoApiModel.fromJson(Map<String, Object?> json) =>
      _$TodoApiModelFromJson(json);
}
