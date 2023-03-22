class GeneralResponseModel {
  GeneralResponseModel({
    required this.error,
    required this.message,
  });

  final bool error;
  final String message;

  factory GeneralResponseModel.fromJson(Map<String, dynamic> json) =>
      GeneralResponseModel(
        error: json["error"],
        message: json["message"],
      );
}
