import 'list_story_response_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_detail_response_model.freezed.dart';
part 'story_detail_response_model.g.dart';

@freezed

class StoryDetailResponseModel with _$StoryDetailResponseModel{
  const factory StoryDetailResponseModel({
    bool? error,
    String? message,
    Story? story,
  }) = _StoryDetailResponseModel;

  factory StoryDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      _$StoryDetailResponseModelFromJson(json);
}
