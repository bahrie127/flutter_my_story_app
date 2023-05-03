// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story_detail_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

StoryDetailResponseModel _$StoryDetailResponseModelFromJson(
    Map<String, dynamic> json) {
  return _StoryDetailResponseModel.fromJson(json);
}

/// @nodoc
mixin _$StoryDetailResponseModel {
  bool? get error => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  Story? get story => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StoryDetailResponseModelCopyWith<StoryDetailResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryDetailResponseModelCopyWith<$Res> {
  factory $StoryDetailResponseModelCopyWith(StoryDetailResponseModel value,
          $Res Function(StoryDetailResponseModel) then) =
      _$StoryDetailResponseModelCopyWithImpl<$Res, StoryDetailResponseModel>;
  @useResult
  $Res call({bool? error, String? message, Story? story});

  $StoryCopyWith<$Res>? get story;
}

/// @nodoc
class _$StoryDetailResponseModelCopyWithImpl<$Res,
        $Val extends StoryDetailResponseModel>
    implements $StoryDetailResponseModelCopyWith<$Res> {
  _$StoryDetailResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? message = freezed,
    Object? story = freezed,
  }) {
    return _then(_value.copyWith(
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      story: freezed == story
          ? _value.story
          : story // ignore: cast_nullable_to_non_nullable
              as Story?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $StoryCopyWith<$Res>? get story {
    if (_value.story == null) {
      return null;
    }

    return $StoryCopyWith<$Res>(_value.story!, (value) {
      return _then(_value.copyWith(story: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_StoryDetailResponseModelCopyWith<$Res>
    implements $StoryDetailResponseModelCopyWith<$Res> {
  factory _$$_StoryDetailResponseModelCopyWith(
          _$_StoryDetailResponseModel value,
          $Res Function(_$_StoryDetailResponseModel) then) =
      __$$_StoryDetailResponseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool? error, String? message, Story? story});

  @override
  $StoryCopyWith<$Res>? get story;
}

/// @nodoc
class __$$_StoryDetailResponseModelCopyWithImpl<$Res>
    extends _$StoryDetailResponseModelCopyWithImpl<$Res,
        _$_StoryDetailResponseModel>
    implements _$$_StoryDetailResponseModelCopyWith<$Res> {
  __$$_StoryDetailResponseModelCopyWithImpl(_$_StoryDetailResponseModel _value,
      $Res Function(_$_StoryDetailResponseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? message = freezed,
    Object? story = freezed,
  }) {
    return _then(_$_StoryDetailResponseModel(
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      story: freezed == story
          ? _value.story
          : story // ignore: cast_nullable_to_non_nullable
              as Story?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_StoryDetailResponseModel implements _StoryDetailResponseModel {
  const _$_StoryDetailResponseModel({this.error, this.message, this.story});

  factory _$_StoryDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      _$$_StoryDetailResponseModelFromJson(json);

  @override
  final bool? error;
  @override
  final String? message;
  @override
  final Story? story;

  @override
  String toString() {
    return 'StoryDetailResponseModel(error: $error, message: $message, story: $story)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StoryDetailResponseModel &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.story, story) || other.story == story));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, error, message, story);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StoryDetailResponseModelCopyWith<_$_StoryDetailResponseModel>
      get copyWith => __$$_StoryDetailResponseModelCopyWithImpl<
          _$_StoryDetailResponseModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_StoryDetailResponseModelToJson(
      this,
    );
  }
}

abstract class _StoryDetailResponseModel implements StoryDetailResponseModel {
  const factory _StoryDetailResponseModel(
      {final bool? error,
      final String? message,
      final Story? story}) = _$_StoryDetailResponseModel;

  factory _StoryDetailResponseModel.fromJson(Map<String, dynamic> json) =
      _$_StoryDetailResponseModel.fromJson;

  @override
  bool? get error;
  @override
  String? get message;
  @override
  Story? get story;
  @override
  @JsonKey(ignore: true)
  _$$_StoryDetailResponseModelCopyWith<_$_StoryDetailResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}
