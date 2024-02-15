import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:frontend/config.dart';
import 'package:frontend/models/position.dart';

class PositionQuerys {
  static Future<List<Position>> getPositions(int working_day_id) async {
    try {
      final response = await Dio().get("${AppConfig.apiUrl}/currentPositions",
          data: {"working_day_id": working_day_id});
      return Position.fromJsonList(response.data);
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<void> addPosition(double latitude, double longitude, int user_id,
      int working_day_id) async {
    try {
      await Dio().post("${AppConfig.apiUrl}/currentPositions", data: {
        "latitude": latitude,
        "longitude": longitude,
        "user_id": user_id,
        "working_day_id": working_day_id
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> updatePosition(double latitude, double longitude, int user_id,
      int working_day_id) async {
    try {
      await Dio().put("${AppConfig.apiUrl}/currentPositions", data: {
        "latitude": latitude,
        "longitude": longitude,
        "user_id": user_id,
        "working_day_id": working_day_id
      });
    } catch (e) {
      print(e);
    }
  }
}
