class User {
  final int id;
  final String email;
  final String name;

  User({this.id, this.email, this.name});

  User.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        email = json["email"],
        name = json["name"];
}
