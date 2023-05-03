// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_detail_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_StoryDetailResponseModel _$$_StoryDetailResponseModelFromJson(
        Map<String, dynamic> json) =>
    _$_StoryDetailResponseModel(
      error: json['error'] as bool?,
      message: json['message'] as String?,
      story: json['story'] == null
          ? null
          : Story.fromJson(json['story'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_StoryDetailResponseModelToJson(
        _$_StoryDetailResponseModel instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'story': instance.story,
    };
