class Fruit {
  String name;
  int price;
  String icon;

  Fruit({this.name = "", this.price = 0, this.icon = ""});
  Fruit.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        price = json['price'],
        icon = json['icon'];
}
