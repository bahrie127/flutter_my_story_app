import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:flutter_my_story_app/data/models/general_response_model.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_my_story_app/common/constants.dart';
import 'package:flutter_my_story_app/data/local/auth_preferences.dart';

import '../models/list_story_response_model.dart';
import '../models/story_detail_response_model.dart';
import '../models/request/story_request_model.dart';

class StoryService {
  final AuthPreference authPreference;
  StoryService({
    required this.authPreference,
  });

  Future<Either<GeneralResponseModel, ListStoryResponseModel>>
      getAllStory() async {
    final token = (await authPreference.getAuthData())!.token;
    final response = await http.get(
      Uri.parse("${Constants.baseUrl}/stories"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return Right(
        ListStoryResponseModel.fromJson(jsonDecode(response.body)),
      );
    } else {
      return Left(
        GeneralResponseModel.fromJson(jsonDecode(response.body)),
      );
    }
  }

  Future<Either<GeneralResponseModel, StoryDetailResponseModel>> getStoryDetail(
    String id,
  ) async {
    final token = (await authPreference.getAuthData())!.token;
    final response = await http.get(
      Uri.parse("${Constants.baseUrl}/stories/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return Right(
        StoryDetailResponseModel.fromJson(jsonDecode(response.body)),
      );
    } else {
      return Left(
        GeneralResponseModel.fromJson(jsonDecode(response.body)),
      );
    }
  }

  Future<Either<GeneralResponseModel, GeneralResponseModel>> addStory(
    StoryRequestModel storyData,
  ) async {
    final token = (await authPreference.getAuthData())!.token;
    final uri = Uri.parse("${Constants.baseUrl}/stories");
    var request = http.MultipartRequest('POST', uri);

    final fileName = storyData.image.name;
    final bytes = await storyData.image.readAsBytes();

    final multiPartFile =
        http.MultipartFile.fromBytes("photo", bytes, filename: fileName);

    final Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    };

    final Map<String, String> fields = {
      "description": storyData.description,
    };

    request.files.add(multiPartFile);
    request.fields.addAll(fields);
    request.headers.addAll(headers);

    final http.StreamedResponse streamedResponse = await request.send();
    final int statusCode = streamedResponse.statusCode;

    final Uint8List responseList = await streamedResponse.stream.toBytes();
    final String responseData = String.fromCharCodes(responseList);

    if (statusCode == 201) {
      return Right(GeneralResponseModel.fromJson(jsonDecode(responseData)));
    } else {
      return Left(GeneralResponseModel.fromJson(jsonDecode(responseData)));
    }
  }
}
