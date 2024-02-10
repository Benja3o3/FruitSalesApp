class Profile {
  int id;
  String username;
  String type;

  Profile({this.id = 1, this.username = "", this.type = ""});
  Profile.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        type = json['type'];
}
