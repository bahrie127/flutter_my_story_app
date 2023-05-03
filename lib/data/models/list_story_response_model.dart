import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_story_response_model.freezed.dart';
part 'list_story_response_model.g.dart';

@freezed
class ListStoryResponseModel with _$ListStoryResponseModel {
  const factory ListStoryResponseModel({
    bool? error,
    String? message,
    List<Story>? listStory,
  }) = _ListStoryResponseModel;

  factory ListStoryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ListStoryResponseModelFromJson(json);
}

@freezed
class Story with _$Story {
  const factory Story({
    String? id,
    String? name,
    String? description,
    String? photoUrl,
    DateTime? createdAt,
    double? lat,
    double? lon,
  }) = _Story;

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);
}
