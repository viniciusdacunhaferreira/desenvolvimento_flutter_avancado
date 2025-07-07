// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo_api_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TodoApiModel {
  String get title;
  String get id;
  bool get done;
  String? get description;

  /// Create a copy of TodoApiModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TodoApiModelCopyWith<TodoApiModel> get copyWith =>
      _$TodoApiModelCopyWithImpl<TodoApiModel>(
          this as TodoApiModel, _$identity);

  /// Serializes this TodoApiModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TodoApiModel &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.done, done) || other.done == done) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, id, done, description);

  @override
  String toString() {
    return 'TodoApiModel(title: $title, id: $id, done: $done, description: $description)';
  }
}

/// @nodoc
abstract mixin class $TodoApiModelCopyWith<$Res> {
  factory $TodoApiModelCopyWith(
          TodoApiModel value, $Res Function(TodoApiModel) _then) =
      _$TodoApiModelCopyWithImpl;
  @useResult
  $Res call({String title, String id, bool done, String? description});
}

/// @nodoc
class _$TodoApiModelCopyWithImpl<$Res> implements $TodoApiModelCopyWith<$Res> {
  _$TodoApiModelCopyWithImpl(this._self, this._then);

  final TodoApiModel _self;
  final $Res Function(TodoApiModel) _then;

  /// Create a copy of TodoApiModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? id = null,
    Object? done = null,
    Object? description = freezed,
  }) {
    return _then(_self.copyWith(
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      done: null == done
          ? _self.done
          : done // ignore: cast_nullable_to_non_nullable
              as bool,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _TodoApiModel implements TodoApiModel {
  const _TodoApiModel(
      {required this.title,
      required this.id,
      required this.done,
      this.description});
  factory _TodoApiModel.fromJson(Map<String, dynamic> json) =>
      _$TodoApiModelFromJson(json);

  @override
  final String title;
  @override
  final String id;
  @override
  final bool done;
  @override
  final String? description;

  /// Create a copy of TodoApiModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TodoApiModelCopyWith<_TodoApiModel> get copyWith =>
      __$TodoApiModelCopyWithImpl<_TodoApiModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TodoApiModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TodoApiModel &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.done, done) || other.done == done) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, id, done, description);

  @override
  String toString() {
    return 'TodoApiModel(title: $title, id: $id, done: $done, description: $description)';
  }
}

/// @nodoc
abstract mixin class _$TodoApiModelCopyWith<$Res>
    implements $TodoApiModelCopyWith<$Res> {
  factory _$TodoApiModelCopyWith(
          _TodoApiModel value, $Res Function(_TodoApiModel) _then) =
      __$TodoApiModelCopyWithImpl;
  @override
  @useResult
  $Res call({String title, String id, bool done, String? description});
}

/// @nodoc
class __$TodoApiModelCopyWithImpl<$Res>
    implements _$TodoApiModelCopyWith<$Res> {
  __$TodoApiModelCopyWithImpl(this._self, this._then);

  final _TodoApiModel _self;
  final $Res Function(_TodoApiModel) _then;

  /// Create a copy of TodoApiModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? title = null,
    Object? id = null,
    Object? done = null,
    Object? description = freezed,
  }) {
    return _then(_TodoApiModel(
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      done: null == done
          ? _self.done
          : done // ignore: cast_nullable_to_non_nullable
              as bool,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
