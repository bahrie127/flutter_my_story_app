import 'package:image_picker/image_picker.dart';

class StoryRequestModel {
  final String description;
  final XFile image;
  final double? lat;
  final double? long;

  StoryRequestModel({
    required this.description,
    required this.image,
    this.lat,
    this.long,
  });

  Map<String, String> toJson() {
    if (lat == null && long == null) {
      return {
        'description': description,
      };
    }

    return {
      'description': description,
      'lat': lat?.toString() ?? '',
      'lon': long?.toString() ?? '',
    };
  }
}
