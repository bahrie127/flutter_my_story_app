// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'general_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GeneralResponseModel _$GeneralResponseModelFromJson(Map<String, dynamic> json) {
  return _GeneralResponseModel.fromJson(json);
}

/// @nodoc
mixin _$GeneralResponseModel {
  bool get error => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GeneralResponseModelCopyWith<GeneralResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeneralResponseModelCopyWith<$Res> {
  factory $GeneralResponseModelCopyWith(GeneralResponseModel value,
          $Res Function(GeneralResponseModel) then) =
      _$GeneralResponseModelCopyWithImpl<$Res, GeneralResponseModel>;
  @useResult
  $Res call({bool error, String message});
}

/// @nodoc
class _$GeneralResponseModelCopyWithImpl<$Res,
        $Val extends GeneralResponseModel>
    implements $GeneralResponseModelCopyWith<$Res> {
  _$GeneralResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GeneralResponseModelCopyWith<$Res>
    implements $GeneralResponseModelCopyWith<$Res> {
  factory _$$_GeneralResponseModelCopyWith(_$_GeneralResponseModel value,
          $Res Function(_$_GeneralResponseModel) then) =
      __$$_GeneralResponseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool error, String message});
}

/// @nodoc
class __$$_GeneralResponseModelCopyWithImpl<$Res>
    extends _$GeneralResponseModelCopyWithImpl<$Res, _$_GeneralResponseModel>
    implements _$$_GeneralResponseModelCopyWith<$Res> {
  __$$_GeneralResponseModelCopyWithImpl(_$_GeneralResponseModel _value,
      $Res Function(_$_GeneralResponseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
  }) {
    return _then(_$_GeneralResponseModel(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GeneralResponseModel implements _GeneralResponseModel {
  const _$_GeneralResponseModel({required this.error, required this.message});

  factory _$_GeneralResponseModel.fromJson(Map<String, dynamic> json) =>
      _$$_GeneralResponseModelFromJson(json);

  @override
  final bool error;
  @override
  final String message;

  @override
  String toString() {
    return 'GeneralResponseModel(error: $error, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GeneralResponseModel &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, error, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GeneralResponseModelCopyWith<_$_GeneralResponseModel> get copyWith =>
      __$$_GeneralResponseModelCopyWithImpl<_$_GeneralResponseModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GeneralResponseModelToJson(
      this,
    );
  }
}

abstract class _GeneralResponseModel implements GeneralResponseModel {
  const factory _GeneralResponseModel(
      {required final bool error,
      required final String message}) = _$_GeneralResponseModel;

  factory _GeneralResponseModel.fromJson(Map<String, dynamic> json) =
      _$_GeneralResponseModel.fromJson;

  @override
  bool get error;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$_GeneralResponseModelCopyWith<_$_GeneralResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}
