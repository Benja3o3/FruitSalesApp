class PositionHistory {
  final int user_id;
  final List<Map<String, double>> coordinates_list;

  PositionHistory({this.user_id = 1, this.coordinates_list = const []});

  PositionHistory.fromJson(Map<String, dynamic> json)
      : user_id = json['user_id'],
        coordinates_list =
            (json['coordinates_list'] as List<dynamic>).map((coordinate) {
          return {
            'x': (coordinate['x'] as num).toDouble(),
            'y': (coordinate['y'] as num).toDouble(),
          };
        }).toList();

  Map<String, dynamic> toJson() => {
        'user_id': user_id,
        'coordinates_list': coordinates_list
            .map((coordinate) => {
                  'x': coordinate['x'],
                  'y': coordinate['y'],
                })
            .toList(),
      };

  static List<PositionHistory> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => PositionHistory.fromJson(json)).toList();
  }
}
