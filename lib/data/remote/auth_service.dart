import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_my_story_app/common/constants.dart';
import 'package:flutter_my_story_app/data/models/general_response_model.dart';
import 'package:flutter_my_story_app/data/models/login_response_model.dart';
import 'package:http/http.dart' as http;

import '../models/login_request_model.dart';
import '../models/register_request_model.dart';
import '../models/register_response_model.dart';

class AuthService {
  Future<Either<GeneralResponseModel, RegisterResponseModel>> register(
    RegisterRequestModel registerData,
  ) async {
    final response = await http.post(
      Uri.parse("${Constants.baseUrl}/register"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        registerData.toJson(),
      ),
    );

    if (response.statusCode == 201) {
      return Right(
        RegisterResponseModel.fromJson(jsonDecode(response.body)),
      );
    } else {
      return Left(
        GeneralResponseModel.fromJson(jsonDecode(response.body)),
      );
    }
  }

  Future<Either<GeneralResponseModel, LoginResponseModel>> login(
      LoginRequestModel loginData) async {
    final response = await http.post(
      Uri.parse("${Constants.baseUrl}/login"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        loginData.toJson(),
      ),
    );

    if (response.statusCode == 200) {
      return Right(LoginResponseModel.fromJson(jsonDecode(response.body)));
    } else {
      return Left(GeneralResponseModel.fromJson(jsonDecode(response.body)));
    }
  }
}
