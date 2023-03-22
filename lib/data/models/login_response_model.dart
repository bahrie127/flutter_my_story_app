class LoginResponseModel {
  LoginResponseModel({
    required this.error,
    required this.message,
    required this.loginResult,
  });

  final bool error;
  final String message;
  final LoginResult loginResult;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        error: json["error"],
        message: json["message"],
        loginResult: LoginResult.fromJson(json["loginResult"]),
      );
}

class LoginResult {
  LoginResult({
    required this.userId,
    required this.name,
    required this.token,
  });

  final String userId;
  final String name;
  final String token;

  factory LoginResult.fromJson(Map<String, dynamic> json) => LoginResult(
        userId: json["userId"],
        name: json["name"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "name": name,
        "token": token,
      };
}
