import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:frontend/config.dart';
import 'package:frontend/models/fruit.dart';

class FruitQuerys {
  final dio = Dio();

  Future<Fruit> getToken() async {
    final response = await dio.get("${AppConfig.apiUrl}/fruit");
    return Fruit.fromJson(response.data);
  }
}
