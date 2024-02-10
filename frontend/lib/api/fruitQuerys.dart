import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:frontend/config.dart';
import 'package:frontend/models/fruit.dart';
import 'package:frontend/models/fruitSell.dart';

class FruitQuerys {
  final dio = Dio();

  Future<List<Fruit>> getFruits() async {
    final response = await dio.get("${AppConfig.apiUrl}/fruit");
    return Fruit.fromJsonList(response.data);
  }

  Future<void> newDay(int id) async {
    await dio.post("${AppConfig.apiUrl}/workingDay", data: {"id": id});
  }

  Future<void> newDayWithFruits(
      int workingDayId, List<int> fruit_id, int created_by) async {
    await dio.post("${AppConfig.apiUrl}/toWorkingDay", data: {
      "working_day_id": workingDayId,
      "fruit_id": fruit_id,
      "created_by": created_by
    });
  }

  Future<List<FruitSell>> getFruitSell(int user_id, int working_day_id) async {
    final response = await dio.get("${AppConfig.apiUrl}/fruitUserSell",
        data: {"user_id": user_id, "working_day_id": working_day_id});
    return FruitSell.fromJsonList(response.data);
  }
}
