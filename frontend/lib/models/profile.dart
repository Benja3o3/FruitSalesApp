class Profile {
  String username;
  String type;

  Profile({this.username = "", this.type = ""});
  Profile.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        type = json['type'];
}
