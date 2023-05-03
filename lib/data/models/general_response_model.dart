import 'package:freezed_annotation/freezed_annotation.dart';

part 'general_response_model.freezed.dart';
part 'general_response_model.g.dart';

@freezed
class GeneralResponseModel with _$GeneralResponseModel {
  const factory GeneralResponseModel({
    required String error,
    required String message,
  }) = _GeneralResponseModel;

  factory GeneralResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GeneralResponseModelFromJson(json);
}
