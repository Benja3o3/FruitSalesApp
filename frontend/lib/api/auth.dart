import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:frontend/models/profile.dart';
import 'package:frontend/models/token.dart';
import 'package:frontend/config.dart';

class Auth {
  final dio = Dio();

  Future<Token> getToken() async {
    final response = await dio.post("${AppConfig.apiUrl}/login", data: {
      "username": "admin",
      "password": "123",
    });
    return Token(token: response.data["token"]);
  }

  Future<Profile> getProfile(String token) async {
    final response = await dio.get("${AppConfig.apiUrl}/profile",
        options: Options(headers: {
          "Authorization": "Bearer $token",
        }));
    print(response.data);
    return Profile.fromJson(response.data);
  }
}
