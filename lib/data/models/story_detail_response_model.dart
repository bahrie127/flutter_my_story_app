import 'list_story_response_model.dart';

class StoryDetailResponseModel {
  StoryDetailResponseModel({
    this.error,
    this.message,
    this.story,
  });

  bool? error;
  String? message;
  Story? story;

  factory StoryDetailResponseModel.fromJson(
    Map<String, dynamic> json,
  ) =>
      StoryDetailResponseModel(
        error: json["error"],
        message: json["message"],
        story: json["story"] == null
            ? null
            : Story.fromJson(
                json["story"],
              ),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "story": story?.toJson(),
      };
}
