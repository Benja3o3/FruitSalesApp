class FruitSell {
  int id;
  String name;
  int price;
  String icon;
  String cantidad;

  FruitSell(
      {this.cantidad = "0",
      this.id = 0,
      this.name = "",
      this.price = 0,
      this.icon = ""});
  FruitSell.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        price = json['price'],
        icon = json['icon'],
        cantidad = json['cantidad'];

  static List<FruitSell> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => FruitSell.fromJson(json)).toList();
  }
}
