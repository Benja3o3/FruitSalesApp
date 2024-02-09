class Fruit {
  int id;
  String name;
  int price;
  String icon;

  Fruit({this.id = 0, this.name = "", this.price = 0, this.icon = ""});
  Fruit.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        price = json['price'],
        icon = json['icon'];

  static List<Fruit> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Fruit.fromJson(json)).toList();
  }
}
