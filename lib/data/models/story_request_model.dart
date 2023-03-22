import 'package:image_picker/image_picker.dart';

class StoryRequestModel {
  final String description;
  final XFile image;

  StoryRequestModel({
    required this.description,
    required this.image,
  });
}
