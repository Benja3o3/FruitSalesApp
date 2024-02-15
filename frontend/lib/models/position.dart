import 'dart:ffi';

class Position {
  double latitude;
  double longitude;
  int user_id;
  String type;

  Position(
      {this.latitude = 0,
      this.longitude = 0,
      this.user_id = 0,
      this.type = ""});

  Position.fromJson(Map<String, dynamic> json)
      : latitude = json['latitude'],
        longitude = json['longitude'],
        user_id = json['user_id'],
        type = json['type'];

  static List<Position> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Position.fromJson(json)).toList();
  }
}
