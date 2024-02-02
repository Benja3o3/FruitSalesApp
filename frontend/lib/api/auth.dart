import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:frontend/models/profile.dart';
import 'package:frontend/models/token.dart';

class Auth {
  final dio = Dio();

  Future<Token> getToken() async {
    final response = await dio.post("http://10.0.2.2:8000/login", data: {
      "username": "dui",
      "password": "123",
    });
    return Token(token: response.data["token"]);
  }

  Future<Profile> getProfile(String token) async {
    final response = await dio.get("http://10.0.2.2:8000/profile",
        options: Options(headers: {
          "Authorization": "Bearer $token",
        }));
    return Profile.fromJson(response.data);
  }
}
