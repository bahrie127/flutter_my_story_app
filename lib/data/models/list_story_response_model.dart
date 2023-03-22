class ListStoryResponseModel {
  ListStoryResponseModel({
    this.error,
    this.message,
    this.listStory,
  });

  bool? error;
  String? message;
  List<Story>? listStory;

  factory ListStoryResponseModel.fromJson(Map<String, dynamic> json) =>
      ListStoryResponseModel(
        error: json["error"],
        message: json["message"],
        listStory: json["listStory"] == null
            ? []
            : List<Story>.from(
                json["listStory"]!.map(
                  (x) => Story.fromJson(x),
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "listStory": listStory == null
            ? []
            : List<dynamic>.from(
                listStory!.map(
                  (x) => x.toJson(),
                ),
              ),
      };
}

class Story {
  Story({
    this.id,
    this.name,
    this.description,
    this.photoUrl,
    this.createdAt,
    this.lat,
    this.lon,
  });

  String? id;
  String? name;
  String? description;
  String? photoUrl;
  DateTime? createdAt;
  double? lat;
  double? lon;

  factory Story.fromJson(Map<String, dynamic> json) => Story(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        photoUrl: json["photoUrl"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "photoUrl": photoUrl,
        "createdAt": createdAt?.toIso8601String(),
        "lat": lat,
        "lon": lon,
      };
}
